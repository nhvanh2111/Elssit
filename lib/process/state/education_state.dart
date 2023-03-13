import 'package:flutter/Material.dart';

abstract class EducationState {}

class OtherEducationState extends EducationState {}

class DateStartEducationState extends EducationState {
  DateStartEducationState({required this.dateStartController});

  final TextEditingController dateStartController;
}

class DateEndEducationState extends EducationState {
  DateEndEducationState({required this.dateEndController});

  final TextEditingController dateEndController;
}
