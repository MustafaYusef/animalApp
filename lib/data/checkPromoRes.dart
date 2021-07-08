// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CheckPromoModel checkPromoModelFromJson(String str) =>
    CheckPromoModel.fromJson(json.decode(str));

class CheckPromoModel {
  CheckPromoModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory CheckPromoModel.fromJson(Map<String, dynamic> json) =>
      CheckPromoModel(
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
    this.amount,
  });

  int? amount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}
