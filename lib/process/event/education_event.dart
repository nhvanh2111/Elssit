import 'package:flutter/Material.dart';

abstract class EducationEvent {}

class ChooseStartDateEducationEvent extends EducationEvent {
  ChooseStartDateEducationEvent({required this.startDate});

  String startDate;
}

class ChooseEndDateEducationEvent extends EducationEvent {
  ChooseEndDateEducationEvent({required this.endDate});

  String endDate;
}

class ChooseEducationLevelEducationEvent extends EducationEvent {
  ChooseEducationLevelEducationEvent({required this.educationLevel});
  String educationLevel;
}

class ChooseMajorLevelEducationEvent extends EducationEvent {
  ChooseMajorLevelEducationEvent({required this.major});
  String major;
}

class FillCourseEducationEvent extends EducationEvent {
  FillCourseEducationEvent({required this.course});
  String course;
}

class FillSchoolEducationEvent extends EducationEvent {
  FillSchoolEducationEvent({required this.school});
  String school;
}

class FillGPAEducationEvent extends EducationEvent {
  FillGPAEducationEvent({required this.gpa});
  String gpa;
}

class FillDescriptionEducationEvent extends EducationEvent {
  FillDescriptionEducationEvent({required this.description});
  String description;
}

class EducationImgSitEvent extends EducationEvent {
  EducationImgSitEvent({required this.educationImg});
  String educationImg;
}
class GraduatedEducationEvent extends EducationEvent{
  GraduatedEducationEvent({required this.isGraduated});
  bool isGraduated;
}
class SaveEducationEvent extends EducationEvent {
  SaveEducationEvent({required this.context});
  BuildContext context;
}
