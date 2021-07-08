// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ServicesModel servicesModelFromJson(String str) =>
    ServicesModel.fromJson(json.decode(str));

class ServicesModel {
  ServicesModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.services,
  });

  List<Service>? services;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    this.id,
    this.name,
    this.inHouse,
    this.softDelete,
    this.cost,
    this.photo,
  });

  int? id;
  String? name;
  int? inHouse;
  bool? softDelete;
  String? cost;
  String? photo;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        inHouse: json["in_house"],
        softDelete: json["softDelete"],
        cost: json["cost"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "in_house": inHouse,
        "softDelete": softDelete,
        "cost": cost,
        "photo": photo,
      };
}
