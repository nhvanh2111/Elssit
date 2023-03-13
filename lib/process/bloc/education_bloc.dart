import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/process/event/education_event.dart';
import 'package:elssit/process/state/education_state.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/globals.dart' as globals;
import '../../core/validators/validations.dart';

class EducationBloc {
  final eventController = StreamController<EducationEvent>();

  final stateController = StreamController<EducationState>();

  final Map<String, String> errors = HashMap();

  String? dateFrom;
  String? dateTo;
  String? educationLevel;
  String? course;
  String? school;
  String? gpa;
  String? description;
  String? educationImg;
  String? major;
  bool? graduated;

  EducationBloc() {
    eventController.stream.listen((event) {
      if (event is ChooseStartDateEducationEvent) {
        dateFrom = event.startDate;
        stateController.sink.add(DateStartEducationState(
            dateStartController: TextEditingController(
                text: MyUtils().educationDateFormat(event.startDate))));
      }
      if (event is ChooseEndDateEducationEvent) {
        dateTo = event.endDate;
        stateController.sink.add(DateEndEducationState(
            dateEndController: TextEditingController(
                text: MyUtils().educationDateFormat(event.endDate))));
      }
      if (event is ChooseEducationLevelEducationEvent) {
        educationLevel = event.educationLevel;
      }
      if (event is ChooseMajorLevelEducationEvent) {
        major = event.major;
      }
      if (event is FillCourseEducationEvent) {
        course = event.course;
      }
      if (event is FillSchoolEducationEvent) {
        school = event.school;
      }
      if (event is FillGPAEducationEvent) {
        gpa = event.gpa;
      }
      if (event is FillDescriptionEducationEvent) {
        description = event.description;
      }
      if (event is EducationImgSitEvent) {
        educationImg = event.educationImg;
        errors.remove("educationImg");
      }
      if (event is GraduatedEducationEvent) {
        graduated = event.isGraduated;
      }
      if (event is SaveEducationEvent) {
        if(educationValidation()){
          createEducation(event.context);
        }
      }
    });
  }

  bool educationValidation() {
    bool isValid = false;
    bool isValidEducationLevel = false;
    bool isValidCourse = false;
    bool isValidSchool = false;
    bool isValidTime = false;
    bool isValidMajor = false;
    bool isValidEducationImg = false;
    if (educationLevel != null) {
      errors.remove("educationLevel");
      isValidEducationLevel = true;
    } else {
      errors.addAll({"educationLevel": "Vui lòng chọn trình độ học vấn"});
      stateController.sink.addError(errors);
    }
    if (major != null) {
      errors.remove("major");
      isValidMajor = true;
    } else {
      errors.addAll({"major": "Vui lòng chọn chuyên ngành"});
      stateController.sink.addError(errors);
    }
    if (course != null && course!.isNotEmpty) {
      errors.remove("course");
      isValidCourse = true;
    } else {
      errors.addAll({"course": "Vui lòng nhập khóa học"});
      stateController.sink.addError(errors);
    }
    if (school != null && school!.isNotEmpty) {
      errors.remove("school");
      isValidSchool = true;
    } else {
      errors.addAll({"school": "Vui lòng nhập trường"});
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
    if (educationImg != null) {
      isValidEducationImg = true;
      errors.remove("educationImg");
    } else {
      errors
          .addAll({"educationImg": "Vui lòng tải lên chứng chỉ đã tốt nghiệp"});
    }
    if (isValidEducationLevel &&
        isValidCourse &&
        isValidSchool &&
        isValidTime &&
        isValidEducationImg &&
        isValidMajor) {
      isValid = true;
      stateController.sink.add(OtherEducationState());
    }
    return isValid;
  }

  Future<void> createEducation(BuildContext context) async {
    try {
      var url = Uri.parse(
          "https://octopus-app-dtd8l.ondigitalocean.app/api/v1/education/mobile/create");

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': globals.bearerToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            "sitterId": globals.sitterID,
            "educationLevel": educationLevel,
            "major": major,
            "schoolName": school,
            "fromDate": MyUtils().convertInputDate(dateFrom!),
            "endDate": MyUtils().convertInputDate(dateTo!),
            "isGraduate": (graduated != null) ? graduated : false,
            "imgCertificated": educationImg,
            "description": description,
            "gpa": (gpa != null && gpa!.isNotEmpty) ? gpa! : 0,
          },
        ),
      );

      print(
          'Test status code updateEducation: ${response.statusCode}');
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
        // ignore: avoid_print
        print(json.decode(response.body)["message"].toString());
      }
    } finally {}
  }
}
