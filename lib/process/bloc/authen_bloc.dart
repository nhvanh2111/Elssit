import 'dart:async';
import 'dart:convert';
import 'dart:collection';

import 'package:elssit/process/event/authen_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:elssit/core/validators/validations.dart';
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
  String? email;
  String? password;

  AuthenBloc() {
    eventController.stream.listen((AuthenEvent event) {
      if (event is LoginEvent) {
        if (loginValidate()) {
          loginWithAccount(event.context);
        } else {}
      } else if (event is InputEmailEvent) {
        email = event.email;
      } else if (event is InputPasswordEvent) {
        password = event.password;
      } else if (event is LogoutEvent) {
        logout(event.context);
      } else if (event is MaintainLoginEvent) {
        final elsBox = Hive.box('elsBox');
        email = elsBox.get('email');
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
    bool isValidEmail = false;
    bool isValidPassword = false;
    if (email == null || email!.trim().isEmpty) {
      error.addAll({"email": "Vui lòng điền email"});
    } else {
      if (Validations.isValidEmail(email!)) {
        error.remove("email");
        isValidEmail = true;
      } else {
        error.addAll({"email": "Vui lòng nhập đúng định dạng email"});
      }
    }
    if (password == null || password!.trim().isEmpty) {
      error.addAll({"password": "Vui lòng điền mật khẩu"});
    } else {
      if (Validations.isValidPassword(password!)) {
        error.remove("password");
        isValidPassword = true;
      } else {
        error.addAll({
          "password":
              "Mật khẩu phải có tối thiểu 8 ký tự Bao gồm chữ In chữ thường và số"
        });
      }
    }
    if (isValidEmail && isValidPassword) {
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
            'email': email!,
            'password': password!,
            'token': globals.deviceID,
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        globals.bearerToken =
            json.decode(response.body)["data"]["token"].toString();
        if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["authorities"][0]
                    ["authority"]
                .toString() ==
            "SITTER") {
          globals.sitterID =
              Jwt.parseJwt(globals.bearerToken.split(" ")[1])["id"].toString();
          globals.email =
              Jwt.parseJwt(globals.bearerToken.split(" ")[1])["sub"].toString();
          if (Jwt.parseJwt(globals.bearerToken.split(" ")[1])["status"]
                  .toString() ==
              "CREATED") {
            final elsBox = Hive.box('elsBox');
            elsBox.put('checkLogin', true);
            elsBox.put('email', email!);
            elsBox.put('password', password);
            globals.email = email!;
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, '/accountScreen');
          } else {
            final elsBox = Hive.box('elsBox');
            elsBox.put('checkLogin', true);
            elsBox.put('email', email!);
            elsBox.put('password', password);
            globals.email = email!;
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, '/homeScreen');
          }
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
