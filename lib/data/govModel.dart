// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GovermentModel govermentModelFromJson(String str) =>
    GovermentModel.fromJson(json.decode(str));

class GovermentModel {
  GovermentModel({
    @required this.statusCode,
    @required this.message,
    @required this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory GovermentModel.fromJson(Map<String, dynamic> json) => GovermentModel(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    @required this.governorate,
  });

  List<Governorate>? governorate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        governorate: json["governorate"] == null
            ? null
            : List<Governorate>.from(
                json["governorate"].map((x) => Governorate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "governorate": governorate == null
            ? null
            : List<dynamic>.from(governorate!.map((x) => x.toJson())),
      };
}

class Governorate {
  Governorate({
    @required this.id,
    @required this.name,
  });

  int? id;
  String? name;

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
