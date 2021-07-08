// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BannersModel bannersModelFromJson(String str) =>
    BannersModel.fromJson(json.decode(str));

class BannersModel {
  BannersModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
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
    this.banners,
  });

  List<BannerItem>? banners;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banners: List<BannerItem>.from(
            json["banners"].map((x) => BannerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": List<dynamic>.from(banners!.map((x) => x.toJson())),
      };
}

class BannerItem {
  BannerItem({
    this.id,
    this.photo,
  });

  int? id;
  String? photo;

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        id: json["id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
      };
}
