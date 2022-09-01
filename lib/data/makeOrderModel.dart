// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MakeOrderModel makeOrderModelFromJson(String str) =>
    MakeOrderModel.fromJson(json.decode(str));

class MakeOrderModel {
  MakeOrderModel({
    required this.statusCode,
    required this.message,
    @required this.data,
  });

  int statusCode;
  String message;
  Data? data;

  factory MakeOrderModel.fromJson(Map<String, dynamic> json) => MakeOrderModel(
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
  Data({required this.msg, @required this.giftItem, @required this.gift_flag});

  String msg;
  GiftItem? giftItem;
  bool? gift_flag;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        msg: json["msg"] == null ? null : json["msg"],
        giftItem: json["gift_item"] == null
            ? null
            : GiftItem.fromJson(json["gift_item"]),
        gift_flag: json["gift_flag"] == null ? null : json["gift_flag"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "gift_item": giftItem == null ? null : giftItem!.toJson(),
        "gift_flag": gift_flag
      };
}

class GiftItem {
  GiftItem({
    required this.id,
    required this.name,
    required this.softDelete,
    required this.description,
    required this.isGift,
    required this.price,
    required this.buyed,
    required this.offerPrice,
    required this.offer,
    required this.count,
    required this.covePhoto,
    required this.updatedAt,
    required this.createdAt,
  });

  int? id;
  String? name;
  bool? softDelete;
  String? description;
  bool? isGift;
  int? price;
  int? buyed;
  int? offerPrice;
  bool? offer;
  int? count;
  String? covePhoto;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory GiftItem.fromJson(Map<String, dynamic> json) => GiftItem(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        softDelete: json["softDelete"] == null ? null : json["softDelete"],
        description: json["description"] == null ? null : json["description"],
        isGift: json["is_gift"] == null ? null : json["is_gift"],
        price: json["price"] == null ? null : json["price"],
        buyed: json["buyed"] == null ? null : json["buyed"],
        offerPrice: json["offer_price"] == null ? null : json["offer_price"],
        offer: json["offer"] == null ? null : json["offer"],
        count: json["count"] == null ? null : json["count"],
        covePhoto: json["cove_photo"] == null ? null : json["cove_photo"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "softDelete": softDelete == null ? null : softDelete,
        "description": description == null ? null : description,
        "is_gift": isGift == null ? null : isGift,
        "price": price == null ? null : price,
        "buyed": buyed == null ? null : buyed,
        "offer_price": offerPrice == null ? null : offerPrice,
        "offer": offer == null ? null : offer,
        "count": count == null ? null : count,
        "cove_photo": covePhoto == null ? null : covePhoto,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
      };
}
