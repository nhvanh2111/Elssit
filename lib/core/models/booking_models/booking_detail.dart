// To parse this JSON data, do
//
//     final bookingDetail = bookingDetailFromJson(jsonString);

import 'dart:convert';

BookingDetail bookingDetailFromJson(String str) => BookingDetail.fromJson(json.decode(str));

String bookingDetailToJson(BookingDetail data) => json.encode(data.toJson());

class BookingDetail {
    BookingDetail({
        required this.id,
        required this.address,
        required this.place,
        required this.createDate,
        required this.startDate,
        required this.endDate,
        required this.startTime,
        required this.endTime,
        required this.deposit,
        required this.status,
        required this.totalPrice,
        required this.customerDto,
        required this.elderDto,
        required this.sitterDto,
        required this.bookingDetailFormDtos,
    });

    String id;
    String address;
    String place;
    DateTime createDate;
    DateTime startDate;
    DateTime endDate;
    String startTime;
    String endTime;
    double deposit;
    String status;
    double totalPrice;
    ErDto customerDto;
    ElderDto elderDto;
    ErDto sitterDto;
    List<BookingDetailFormDto> bookingDetailFormDtos;

    factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        id: json["id"],
        address: json["address"],
        place: json["place"],
        createDate: DateTime.parse(json["createDate"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        deposit: json["deposit"],
        status: json["status"],
        totalPrice: json["totalPrice"],
        customerDto: ErDto.fromJson(json["customerDTO"]),
        elderDto: ElderDto.fromJson(json["elderDTO"]),
        sitterDto: ErDto.fromJson(json["sitterDTO"]),
        bookingDetailFormDtos: List<BookingDetailFormDto>.from(json["bookingDetailFormDTOS"].map((x) => BookingDetailFormDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "place": place,
        "createDate": "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "startTime": startTime,
        "endTime": endTime,
        "deposit": deposit,
        "status": status,
        "totalPrice": totalPrice,
        "customerDTO": customerDto.toJson(),
        "elderDTO": elderDto.toJson(),
        "sitterDTO": sitterDto.toJson(),
        "bookingDetailFormDTOS": List<dynamic>.from(bookingDetailFormDtos.map((x) => x.toJson())),
    };
}

class BookingDetailFormDto {
    BookingDetailFormDto({
        required this.id,
        required this.estimateTime,
        required this.packageName,
        required this.startDateTime,
        required this.endDateTime,
        required this.packageDto,
        required this.status,
        required this.detailServiceDtos,
    });

    String id;
    double estimateTime;
    String packageName;
    DateTime startDateTime;
    DateTime endDateTime;
    PackageDto packageDto;
    String status;
    List<DetailServiceDto> detailServiceDtos;

    factory BookingDetailFormDto.fromJson(Map<String, dynamic> json) => BookingDetailFormDto(
        id: json["id"],
        estimateTime: json["estimateTime"].toDouble(),
        packageName: json["packageName"],
        startDateTime: DateTime.parse(json["startDateTime"]),
        endDateTime: DateTime.parse(json["endDateTime"]),
        packageDto: PackageDto.fromJson(json["packageDTO"]),
        status: json["status"],
        detailServiceDtos: List<DetailServiceDto>.from(json["detailServiceDTOS"].map((x) => DetailServiceDto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estimateTime": estimateTime,
        "packageName": packageName,
        "startDateTime": startDateTime.toIso8601String(),
        "endDateTime": endDateTime.toIso8601String(),
        "packageDTO": packageDto.toJson(),
        "status": status,
        "detailServiceDTOS": List<dynamic>.from(detailServiceDtos.map((x) => x.toJson())),
    };
}

class DetailServiceDto {
    DetailServiceDto({
        required this.id,
        required this.serviceName,
        this.servicePrice,
        this.serviceDuration,
    });

    String id;
    String serviceName;
    dynamic servicePrice;
    dynamic serviceDuration;

    factory DetailServiceDto.fromJson(Map<String, dynamic> json) => DetailServiceDto(
        id: json["id"],
        serviceName: json["serviceName"],
        servicePrice: json["servicePrice"],
        serviceDuration: json["serviceDuration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "serviceName": serviceName,
        "servicePrice": servicePrice,
        "serviceDuration": serviceDuration,
    };
}

class PackageDto {
    PackageDto({
        required this.id,
        required this.name,
        this.img,
        required this.duration,
        required this.price,
        required this.desc,
        this.status,
    });

    String id;
    String name;
    dynamic img;
    int duration;
    double price;
    String desc;
    dynamic status;

    factory PackageDto.fromJson(Map<String, dynamic> json) => PackageDto(
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

class ErDto {
    ErDto({
        required this.id,
        required this.fullName,
        required this.phone,
        required this.email,
        this.address,
        this.gender,
        required this.status,
    });

    String id;
    String fullName;
    String phone;
    String email;
    String? address;
    String? gender;
    String status;

    factory ErDto.fromJson(Map<String, dynamic> json) => ErDto(
        id: json["id"],
        fullName: json["fullName"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        gender: json["gender"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "address": address,
        "gender": gender,
        "status": status,
    };
}

class ElderDto {
    ElderDto({
        required this.id,
        required this.fullName,
        required this.dob,
        required this.gender,
    });

    String id;
    String fullName;
    DateTime dob;
    String gender;

    factory ElderDto.fromJson(Map<String, dynamic> json) => ElderDto(
        id: json["id"],
        fullName: json["fullName"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender,
    };
}
