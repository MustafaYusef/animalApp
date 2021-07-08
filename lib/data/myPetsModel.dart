// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyPetsModel myPetsModelFromJson(String str) =>
    MyPetsModel.fromJson(json.decode(str));

class MyPetsModel {
  MyPetsModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory MyPetsModel.fromJson(Map<String, dynamic> json) => MyPetsModel(
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
    this.myPet,
  });

  List<MyPet>? myPet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myPet: List<MyPet>.from(json["my_pet"].map((x) => MyPet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "my_pet": List<dynamic>.from(myPet!.map((x) => x.toJson())),
      };
}

class MyPet {
  MyPet({
    this.id,
    this.name,
    this.type,
    this.age,
    this.sex,
    this.softDelete,
    this.description,
    this.lastVaccine,
    this.photo,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  String? name;
  String? type;
  DateTime? age;
  int? sex;
  bool? softDelete;
  String? description;
  var lastVaccine;
  String? photo;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory MyPet.fromJson(Map<String, dynamic> json) => MyPet(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        age: DateTime.parse(json["age"]),
        sex: json["sex"],
        softDelete: json["softDelete"],
        description: json["description"],
        lastVaccine: json["last_vaccine"],
        photo: json["photo"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "age": age!.toIso8601String(),
        "sex": sex,
        "softDelete": softDelete,
        "description": description,
        "last_vaccine": lastVaccine.toIso8601String(),
        "photo": photo,
        "updatedAt": updatedAt!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
      };
}
