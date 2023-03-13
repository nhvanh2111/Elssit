class SitDetailDataModel {
  SitDetailDataModel({
    required this.sitterId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.dob,
    required this.gender,
    required this.status,
    required this.idNumber,
    required this.description,
    required this.avatarImg,
    required this.backCardImg,
    required this.frontCardImg,
    this.createDate,
  });

  String sitterId;
  String fullName;
  String email;
  String phone;
  String address;
  String dob;
  String gender;
  String status;
  String idNumber;
  String description;
  String avatarImg;
  String backCardImg;
  String frontCardImg;
  dynamic createDate;

  factory SitDetailDataModel.fromJson(Map<String, dynamic> json) =>
      SitDetailDataModel(
        sitterId: json["sitterId"],
        fullName: (json["fullName"] != null) ? json["fullName"] : "",
        email: (json["email"] != null) ? json["email"] : "",
        phone: (json["phone"] != null) ? json["phone"] : "",
        address: (json["address"] != null) ? json["address"] : "",
        dob: (json["dob"] != null) ? json["dob"] : "",
        gender: (json["gender"] != null) ? json["gender"] : "",
        status: (json["status"] != null) ? json["status"] : "",
        idNumber: (json["idNumber"] != null) ? json["idNumber"] : "",
        description: (json["desc"] != null) ? json["desc"] : "",
        avatarImg: (json["avatarImg"] != null) ? json["avatarImg"] : "",
        backCardImg: (json["backCardImg"] != null) ? json["backCardImg"] : "",
        frontCardImg:
            (json["frontCardImg"] != null) ? json["frontCardImg"] : "",
        createDate: (json["createDate"] != null) ? json["createDate"] : "",
      );

  Map<String, dynamic> toJson() => {
        "sitterId": sitterId,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "address": address,
        "dob": dob,
        "gender": gender,
        "status": status,
        "idNumber": idNumber,
        "desc": description,
        "avatarImg": avatarImg,
        "backCardImg": backCardImg,
        "frontCardImg": frontCardImg,
        "createDate": createDate,
      };
}
