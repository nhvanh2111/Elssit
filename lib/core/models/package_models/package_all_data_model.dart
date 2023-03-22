import 'dart:ffi';

class PackageAllDataModel {
  PackageAllDataModel({
    required this.id,
    required this.name,
    required this.img,
    required this.duration,
    required this.price,
    required this.desc,
    required this.status,
  });

  String id;
  String name;
  String img;
  int duration;
  double price;
  String desc;
  String status;

  factory PackageAllDataModel.fromJson(Map<String, dynamic> json) =>
      PackageAllDataModel(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        duration: json["duration"],
        price: json["price"],
        desc: json["desc"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "duration": duration,
        "price": price,
        "desc": desc,
        "status": status,
      };
}
