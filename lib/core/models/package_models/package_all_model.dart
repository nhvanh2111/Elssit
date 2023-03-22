import 'package:elssit/core/models/package_models/package_all_data_model.dart';

class PackageAllModel {
  PackageAllModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<PackageAllDataModel> data;

  factory PackageAllModel.fromJson(Map<String, dynamic> json) =>
      PackageAllModel(
        successCode: json["successCode"],
        errorCode: json["errorCode"],
        data: List<PackageAllDataModel>.from(
            json["data"].map((x) => PackageAllDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "successCode": successCode,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
