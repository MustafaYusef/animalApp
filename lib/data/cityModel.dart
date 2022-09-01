// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

class CityModel {
  CityModel({
    required this.statusCode,
    required this.message,
    @required this.data,
  });

  int statusCode;
  String message;
  Data? data;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
    required this.cities,
  });

  List<City>? cities;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cities: json["cities"] == null
            ? null
            : List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cities": cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  City({
    required this.id,
    required this.name,
    required this.shippingPrice,
    required this.fastShipping,
    required this.fastPrice,
  });

  int? id;
  String? name;
  int? shippingPrice;
  bool? fastShipping;
  int? fastPrice;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        shippingPrice:
            json["shipping_price"] == null ? null : json["shipping_price"],
        fastShipping:
            json["fast_shipping"] == null ? null : json["fast_shipping"],
        fastPrice: json["fast_price"] == null ? null : json["fast_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "shipping_price": shippingPrice == null ? null : shippingPrice,
        "fast_shipping": fastShipping == null ? null : fastShipping,
        "fast_price": fastPrice == null ? null : fastPrice,
      };
}
