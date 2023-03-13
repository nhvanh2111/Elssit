import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';
import 'package:elssit/core/utils/my_utils.dart';

import 'package:elssit/process/event/certification_event.dart';
import 'package:elssit/process/state/certification_state.dart';

class CertificationBloc {
  final eventController = StreamController<CertificationEvent>();

  final stateController = StreamController<CertificationState>();

  final Map<String, String> errors = HashMap();

  String? dateFrom;
  String? dateTo;
  String? title;
  String? organization;
  String? credentialID;
  String? credentialURL;
  String? description;
  String? certificationImg;

  CertificationBloc() {
    eventController.stream.listen((event) {
      if (event is ChooseStartDateCertificationEvent) {
        dateFrom = event.startDate;
        stateController.sink.add(DateStartCertificationState(
            dateStartController: TextEditingController(
                text: MyUtils().educationDateFormat(event.startDate))));
      }
      if (event is ChooseEndDateCertificationEvent) {
        dateTo = event.endDate;
        stateController.sink.add(DateEndCertificationState(
            dateEndController: TextEditingController(
                text: MyUtils().educationDateFormat(event.endDate))));
      }
      if (event is FillTitleCertificationEvent) {
        title = event.title;
      }
      if (event is FillOrganizationCertificationEvent) {
        organization = event.organization;
      }
      if (event is FillCredentialIDCertificationEvent) {
        credentialID = event.credentialID;
      }
      if (event is FillCredentialURLCertificationEvent) {
        credentialURL = event.credentialURL;
      }
      if (event is FillDescriptionCertificationEvent) {
        description = event.description;
      }
      if (event is CertificationImgEvent) {
        certificationImg = event.certificationImg;
        errors.remove("certificationImg");
      }
      if (event is SaveCertificationEvent) {
        certificationValidation();
      }
      if(event is GetAllCertCertificationEvent){
        stateController.sink.add(GetAllCertificationState());
      }
    });
  }

  bool certificationValidation() {
    bool isValid = false;
    bool isValidTitle = false;
    bool isValidOrganization = false;
    bool isValidTime = false;
    bool isValidCertificationImg = false;

    if (title != null && title!.isNotEmpty) {
      errors.remove("title");
      isValidTitle = true;
    } else {
      errors.addAll({"title": "Vui lòng nhập tiêu đề của chứng nhận"});
      stateController.sink.addError(errors);
    }
    if (organization != null && organization!.isNotEmpty) {
      errors.remove("organization");
      isValidOrganization = true;
    } else {
      errors.addAll({"organization": "Vui lòng nhập đơn vị cấp chứng nhận"});
      stateController.sink.addError(errors);
    }
    if (dateFrom != null &&
        dateTo != null &&
        dateFrom!.isNotEmpty &&
        dateTo!.isNotEmpty) {
      if (Validations.isValidCourseTime(dateFrom!, dateTo!)) {
        errors.remove("time");
        isValidTime = true;
      } else {
        errors.addAll({"time": "Thời gian không hợp lệ"});
        stateController.sink.addError(errors);
      }
    } else {
      errors.addAll({"time": "Thời gian không hợp lệ"});
      stateController.sink.addError(errors);
    }
    if (certificationImg != null) {
      isValidCertificationImg = true;
      errors.remove("certificationImg");
    } else {
      errors.addAll({"certificationImg": "Vui lòng tải lên chứng chỉ"});
    }
    if (isValidCertificationImg &&
        isValidTitle &&
        isValidOrganization &&
        isValidTime) {
      isValid = true;
      stateController.sink.add(OtherCertificationState());
    }
    return isValid;
  }
}
