import 'dart:async';
import 'dart:convert';
import 'dart:collection';

import 'package:elssit/process/event/authen_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../presentation/widget/dialog/fail_dialog.dart';
import '../state/authen_state.dart';

class AuthenBloc {
  final eventController = StreamController<AuthenEvent>();

  final stateController = StreamController<AuthenState>();

  final Map<String, String> error = HashMap();
  String? username;
  String? password;

  AuthenBloc() {
    eventController.stream.listen((AuthenEvent event) {
      if (event is LoginEvent) {
        if (loginValidate()) {
          loginWithAccount(event.context);
        } else {}
      } else if (event is InputUserNameEvent) {
        username = event.username;
      } else if (event is InputPasswordEvent) {
        password = event.password;
      } else if (event is LogoutEvent) {
        logout(event.context);
      } else if (event is MaintainLoginEvent) {
        final elsBox = Hive.box('elsBox');
        username = elsBox.get('email');
        password = elsBox.get('password');
        loginWithAccount(event.context);
      } else {
        if (kDebugMode) {
          print("AuthenBloc do nothing");
        }
      }
    });
  }

  bool loginValidate() {
    bool isValid = false;
    bool isValidUserName = false;
    bool isValidPassword = false;
    if (username == null || username!.trim().isEmpty) {
      error.addAll({"username": "Vui lòng nhập tài khoản"});
    } else {
      error.remove("username");
      isValidUserName = true;
    }
    if (password == null || password!.trim().isEmpty) {
      error.addAll({"password": "Vui lòng nhập mật khẩu"});
    } else {
      error.remove("password");
      isValidPassword = true;
    }
    if (isValidUserName && isValidPassword) {
      isValid = true;
      stateController.sink.add(OtherAuthenState());
    } else {
      stateController.sink.addError(error);
    }
    return isValid;
  }

  Future<void> loginWithAccount(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/common/auth/login");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'email': username!,
            'password': password!,
            'token': globals.deviceID,
          },
        ),
      );
      print('Test login status: ${response.statusCode.toString()}');
      if (response.statusCode.toString() == '200') {
        globals.bearerToken =
            json.decode(response.body)["data"]["token"].toString();
        if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["authorities"][0]
                    ["authority"]
                .toString() ==
            "SITTER") {
          globals.customerID =
              Jwt.parseJwt(globals.bearerToken.split(" ")[1])["id"].toString();
          globals.email =
              Jwt.parseJwt(globals.bearerToken.split(" ")[1])["sub"].toString();
          globals.customerName =
              Jwt.parseJwt(globals.bearerToken.split(" ")[1])["fullName"]
                  .toString();
          final elsBox = Hive.box('elsBox');
          elsBox.put('checkLogin', true);
          elsBox.put('email', username!);
          elsBox.put('password', password);
          globals.email = username!;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/homeScreen');
        } else {
          // ignore: use_build_context_synchronously
          showFailDialog(
              context, "Tài khoản đã được đăng ký dưới vai trò khác");
        }
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> logout(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/common/auth/logout/${globals.email}");
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{},
        ),
      );
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/loginWithGoogleNav');
      } else {
        if (kDebugMode) {
          print('Đăng xuất thất bại');
        }
      }
    } finally {}
  }
}
