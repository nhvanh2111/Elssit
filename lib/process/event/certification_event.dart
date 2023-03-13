abstract class CertificationEvent {}

class ChooseStartDateCertificationEvent extends CertificationEvent {
  ChooseStartDateCertificationEvent({required this.startDate});
  String startDate;
}

class ChooseEndDateCertificationEvent extends CertificationEvent {
  ChooseEndDateCertificationEvent({required this.endDate});
  String endDate;
}

class FillTitleCertificationEvent extends CertificationEvent {
  FillTitleCertificationEvent({required this.title});
  String title;
}

class FillOrganizationCertificationEvent extends CertificationEvent {
  FillOrganizationCertificationEvent({required this.organization});
  String organization;
}

class FillCredentialIDCertificationEvent extends CertificationEvent {
  FillCredentialIDCertificationEvent({required this.credentialID});
  String credentialID;
}

class FillCredentialURLCertificationEvent extends CertificationEvent {
  FillCredentialURLCertificationEvent({required this.credentialURL});
  String credentialURL;
}

class FillDescriptionCertificationEvent extends CertificationEvent {
  FillDescriptionCertificationEvent({required this.description});
  String description;
}

class CertificationImgEvent extends CertificationEvent {
  CertificationImgEvent({required this.certificationImg});
  String certificationImg;
}

class GetAllCertCertificationEvent extends CertificationEvent{

}

class SaveCertificationEvent extends CertificationEvent {}
