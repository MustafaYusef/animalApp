// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ItemsSearchModel itemsSearchModelFromJson(String str) =>
    ItemsSearchModel.fromJson(json.decode(str));

class ItemsSearchModel {
  ItemsSearchModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory ItemsSearchModel.fromJson(Map<String, dynamic> json) =>
      ItemsSearchModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.item,
  });

  List<ItemSearch> item;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: List<ItemSearch>.from(
            json["item"].map((x) => ItemSearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item": List<dynamic>.from(item.map((x) => x.toJson())),
      };
}

class ItemSearch {
  ItemSearch({
    this.id,
    this.name,
    this.softDelete,
    this.description,
    this.price,
    this.buyed,
    this.offerPrice,
    this.offer,
    this.count,
    this.covePhoto,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  String name;
  bool softDelete;
  String description;
  int price;
  int buyed;
  int offerPrice;
  bool offer;
  int count;
  String covePhoto;
  DateTime updatedAt;
  DateTime createdAt;

  factory ItemSearch.fromJson(Map<String, dynamic> json) => ItemSearch(
        id: json["id"],
        name: json["name"],
        softDelete: json["softDelete"],
        description: json["description"],
        price: json["price"],
        buyed: json["buyed"],
        offerPrice: json["offer_price"],
        offer: json["offer"],
        count: json["count"],
        covePhoto: json["cove_photo"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "softDelete": softDelete,
        "description": description,
        "price": price,
        "buyed": buyed,
        "offer_price": offerPrice,
        "offer": offer,
        "count": count,
        "cove_photo": covePhoto,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
