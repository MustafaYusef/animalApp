// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ShippingPriceRes shippingPriceResFromJson(String str) =>
    ShippingPriceRes.fromJson(json.decode(str));

class ShippingPriceRes {
  ShippingPriceRes({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory ShippingPriceRes.fromJson(Map<String, dynamic> json) =>
      ShippingPriceRes(
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
    this.getShippingPrice,
  });

  List<GetShippingPrice>? getShippingPrice;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        getShippingPrice: List<GetShippingPrice>.from(
            json["get_shippingPrice"].map((x) => GetShippingPrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "get_shippingPrice":
            List<dynamic>.from(getShippingPrice!.map((x) => x.toJson())),
      };
}

class GetShippingPrice {
  GetShippingPrice({
    this.id,
    this.title,
    this.amount,
  });

  int? id;
  String? title;
  int? amount;

  factory GetShippingPrice.fromJson(Map<String, dynamic> json) =>
      GetShippingPrice(
        id: json["id"],
        title: json["title"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "amount": amount,
      };
}
