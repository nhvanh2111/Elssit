import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:flutter/foundation.dart';

import 'package:elssit/core/utils/globals.dart' as globals;
import 'package:elssit/core/validators/validations.dart';
import 'package:elssit/core/models/sitter_models/sitter_detail_model.dart';
import 'package:elssit/process/event/sitter_event.dart';
import 'package:elssit/process/state/sitter_state.dart';

import '../../presentation/widget/dialog/fail_dialog.dart';

class SitBloc {
  final eventController = StreamController<SitEvent>();

  final stateController = StreamController<SitState>();

  String? fullName;
  String? phone;
  String? email;
  String? address;
  String? dob;
  String? gender;
  String? idNumber;
  String? description;
  String? avatarImg;
  String? backCardImg;
  String? frontCardImg;
  String? password;
  String? rePassword;

  final Map<String, String> errors = HashMap();

  SitBloc() {
    eventController.stream.listen((event) {
      if (event is FillFullNameSitEvent) {
        fullName = event.fullName;
        errors.remove("fullName");
      }
      if (event is FillPhoneSitEvent) {
        phone = event.phone;
        errors.remove("phone");
      }
      if (event is FillAddressSitEvent) {
        address = event.address;
        print('Test address: ${event.address}');
        errors.remove("address");
      }
      if (event is FillDobSitEvent) {
        dob = event.dob;
        errors.remove("dob");
      }
      if (event is FillGenderSitEvent) {
        gender = event.gender;
        errors.remove("gender");
      }
      if (event is FillIdNumberSitEvent) {
        idNumber = event.idNumber;
        errors.remove("idNumber");
      }
      if (event is FillDescriptionSitEvent) {
        description = event.description;
        errors.remove("description");
      }
      if (event is AvatarImgSitEvent) {
        avatarImg = event.avatarImg;
        errors.remove("avatarImg");
      }
      if (event is FrontCardImgSitEvent) {
        frontCardImg = event.frontCardImg;
        errors.remove("frontCardImg");
      }
      if (event is BackCardImgSitEvent) {
        backCardImg = event.backCardImg;
        errors.remove("backCardImg");
      }
      if (event is FillEmailSitEvent) {
        email = event.email;
        errors.remove("email");
      }
      if (event is FillPasswordSitEvent) {
        password = event.password;
        errors.remove("password");
      }
      if (event is FillRePasswordSitEvent) {
        rePassword = event.rePassword;
        errors.remove("rePassword");
      }
      if (event is SignUpSitEvent) {
        if (signUpValidate()) {
          sitSignUp(event.context);
        }
      }
      if (event is SaveContactEvent) {
        if (contactValidation()) {
          updateContactInfoSit(event.context);
        }
      }
      if (event is GetContactSitEvent) {
        getContactSitByID();
      }
      if (event is SaveInformationEvent) {
        if(informationValidation()){
          updateInformationInfoSit(event.context);
        }
      }

      if(event is SitOtherEvent){
        stateController.add(SitOtherState());
      }
    });
  }

  bool signUpValidate() {
    bool isValid = false;
    bool isValidEmail = false;
    bool isValidPhone = false;
    bool isValidPassword = false;
    bool isValidRePassword = false;

    if (email == null || email!.trim().isEmpty) {
      errors.addAll({"email": "Vui lòng điền email"});
    } else {
      if (Validations.isValidEmail(email!)) {
        errors.remove("email");
        isValidEmail = true;
      } else {
        errors.addAll({"email": "Vui lòng nhập đúng định dạng email"});
      }
    }
    if (password == null || password!.trim().isEmpty) {
      errors.addAll({"password": "Vui lòng điền mật khẩu"});
    } else {
      if (Validations.isValidPassword(password!)) {
        errors.remove("password");
        isValidPassword = true;
      } else {
        errors.addAll({
          "password":
              "Mật khẩu phải có tối thiểu 8 ký tự Bao gồm chữ In chữ thường và số"
        });
      }
    }
    if (rePassword == null || rePassword!.trim().isEmpty) {
      errors.addAll({"rePassword": "Vui lòng nhập lại mật khẩu"});
    } else {
      if (password == rePassword) {
        errors.remove("rePassword");
        isValidRePassword = true;
      } else {
        errors.addAll({"rePassword": "Mật khẩu không trùng khớp"});
      }
    }
    if (phone == null || phone!.trim().isEmpty) {
      errors.addAll({"phone": "Vui lòng điền số điện thoại"});
    } else {
      if (phone == null || !Validations.isValidPhone(phone!.trim())) {
        errors.addAll({"phone": "Số điện thoại phải có 10 chữ số"});
      } else {
        errors.remove("phone");
        isValidPhone = true;
      }
    }
    if (isValidPhone && isValidEmail && isValidPassword && isValidRePassword) {
      stateController.sink.add(SitOtherState());
      isValid = true;
    } else {
      stateController.sink.addError(errors);
    }

    return isValid;
  }

  bool contactValidation() {
    bool isValid = false;
    bool isValidAddress = false;
    bool isValidPhone = false;

    if (address == null || address!.trim().isEmpty) {
      errors.addAll({"address": "Vui lòng nhập địa chỉ"});
    } else {
      errors.remove("address");
      isValidAddress = true;
    }
    if (phone == null || phone!.trim().isEmpty) {
      errors.addAll({"phone": "Vui lòng điền số điện thoại"});
    } else {
      if (phone == null || !Validations.isValidPhone(phone!.trim())) {
        errors.addAll({"phone": "Số điện thoại phải có 10 chữ số"});
      } else {
        errors.remove("phone");
        isValidPhone = true;
      }
    }
    // ignore: dead_code
    if (isValidAddress && isValidPhone) {
      stateController.sink.add(SitOtherState());
      isValid = true;
    } else {
      stateController.sink.addError(errors);
    }
    return isValid;
  }

  bool informationValidation() {
    bool isValid = false;
    bool isValidAvatarImg = false;
    bool isValidFrontCardImg = false;
    bool isValidBackCardImg = false;
    bool isValidFullName = false;
    bool isValidDob = false;
    bool isValidGender = false;
    bool isValidIdNumber = false;
    if (avatarImg != null) {
      isValidAvatarImg = true;
      errors.remove("avatarImg");
    } else {
      errors.addAll({"avatarImg": "Vui lòng chụp ảnh khuôn mặt"});
    }
    if (frontCardImg != null) {
      isValidFrontCardImg = true;
      errors.remove("frontCardImg");
    } else {
      errors.addAll({"frontCardImg": "Vui lòng chụp ảnh CMND/CCCD mặt trước"});
    }
    if (backCardImg != null) {
      isValidBackCardImg = true;
      errors.remove("backCardImg");
    } else {
      errors.addAll({"backCardImg": "Vui lòng chụp ảnh CMND/CCCD mặt sau"});
    }
    if (fullName != null) {
      isValidFullName = true;
      errors.remove("qr");
    } else {
      errors.addAll({"qr": "Vui lòng quét lại mã QR"});
    }
    if (dob != null) {
      isValidDob = true;
      errors.remove("qr");
    } else {
      errors.addAll({"qr": "Vui lòng quét lại mã QR"});
    }
    if (gender != null) {
      isValidGender = true;
      errors.remove("qr");
    } else {
      errors.addAll({"qr": "Vui lòng quét lại mã QR"});
    }
    if (idNumber != null) {
      isValidIdNumber = true;
      errors.remove("qr");
    } else {
      errors.addAll({"qr": "Vui lòng quét lại mã QR"});
    }
    if (isValidAvatarImg &&
        isValidFrontCardImg &&
        isValidBackCardImg &&
        isValidFullName &&
        isValidDob &&
        isValidGender &&
        isValidIdNumber) {
      isValid = true;
      stateController.sink.add(SitOtherState());
    } else {
      stateController.sink.addError(errors);
    }
    return isValid;
  }

  Future<void> sitSignUp(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/sitter/mobile/register");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": email!,
            "phone": phone!,
            "password": password!
          },
        ),
      );
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/loginWithGoogleNav');
        // MaterialPageRoute(
        //   builder: (context) => const SuccessScreen(
        //       content: "Đăng ký tài khoản thành công",
        //       buttonName: "Trở về trang đăng nhập",
        //       navigatorPath: "/loginWithGoogleNav"),
        // )
        //);
      } else {
        // ignore: use_build_context_synchronously
        // showFailDialog(
        //     context, json.decode(response.body)["message"].toString());
        if (kDebugMode) {
          print('Đăng xuất thất bại');
        }
      }
    } finally {}
  }

  Future<void> updateContactInfoSit(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/sitter/mobile/contact/update");

      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "sitterId": globals.sitterID,
            "address": address,
            "phone": phone,
            "email": email,
            "description": description,
          },
        ),
      );

      print('Test status code updateCus: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/accountScreen');
        // MaterialPageRoute(
        //   builder: (context) => const SuccessScreen(
        //       content: "Đăng ký tài khoản thành công",
        //       buttonName: "Trở về trang đăng nhập",
        //       navigatorPath: "/loginWithGoogleNav"),
        // )
        //);
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getContactSitByID() async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/sitter/mobile/contact/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(SitDetailState(
            sitInfo: SitDetailModel.fromJson(json.decode(response.body)).data));
      } else {
        throw Exception('Unable to fetch cus from the REST API');
      }
    } finally {}
  }

  Future<void> updateInformationInfoSit(BuildContext context) async {

    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/sitter/mobile/information/update");

      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "sitterId": globals.sitterID,
            "fullName": fullName,
            "dob": dob,
            "gender": gender,
            "idNumber": idNumber,
            "avatarImg": avatarImg,
            "backCardImg": backCardImg,
            "frontCardImg": frontCardImg,
          },
        ),
      );

      print('Test status code updateInformationInfoSit: ${response.statusCode}');
      if (response.statusCode.toString() == '200') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/accountScreen');
        // MaterialPageRoute(
        //   builder: (context) => const SuccessScreen(
        //       content: "Đăng ký tài khoản thành công",
        //       buttonName: "Trở về trang đăng nhập",
        //       navigatorPath: "/loginWithGoogleNav"),
        // )
        //);
      } else {
        // ignore: use_build_context_synchronously
        showFailDialog(
            context, json.decode(response.body)["message"].toString());
      }
    } finally {}
  }

  Future<void> getInformationSitByID() async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/sitter/mobile/information/${globals.sitterID}");
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
          'Accept': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode.toString() == '200') {
        stateController.sink.add(SitDetailState(
            sitInfo: SitDetailModel.fromJson(json.decode(response.body)).data));
      } else {
        throw Exception('Unable to fetch cus from the REST API');
      }
    } finally {}
  }
}
