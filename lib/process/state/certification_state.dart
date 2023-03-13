import 'package:flutter/Material.dart';

abstract class CertificationState {}

class OtherCertificationState extends CertificationState {}

class DateStartCertificationState extends CertificationState {
  DateStartCertificationState({required this.dateStartController});

  final TextEditingController dateStartController;
}

class DateEndCertificationState extends CertificationState {
  DateEndCertificationState({required this.dateEndController});

  final TextEditingController dateEndController;
}

class GetAllCertificationState extends CertificationState{
  // GetAllCertificationState({required this.test});
  // String test;
}
