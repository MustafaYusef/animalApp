// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

class CartModel {
  CartModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
    this.myCart,
  });

  List<MyCart>? myCart;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myCart:
            List<MyCart>.from(json["my_cart"].map((x) => MyCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "my_cart": List<dynamic>.from(myCart!.map((x) => x.toJson())),
      };
}

class MyCart {
  MyCart({
    this.id,
    this.count,
    this.offer,
    this.itemId,
    this.itemName,
    this.itemDescription,
    this.itemPrice,
    this.item_count,
    this.itemOfferPrice,
    this.itemPhoto,
  });

  int? id;
  int? count;
  bool? offer;
  int? itemId;
  String? itemName;
  String? itemDescription;
  int? itemPrice;
  int? item_count;
  int? itemOfferPrice;
  String? itemPhoto;

  factory MyCart.fromJson(Map<String, dynamic> json) => MyCart(
        id: json["id"],
        count: json["count"],
        offer: json["offer"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemDescription: json["item_description"],
        itemPrice: json["item_price"],
        item_count: json["item_count"],
        itemOfferPrice: json["item_offer_price"],
        itemPhoto: json["item_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "offer": offer,
        "item_id": itemId,
        "item_name": itemName,
        "item_description": itemDescription,
        "item_price": itemPrice,
        "item_count": item_count,
        "item_offer_price": itemOfferPrice,
        "item_photo": itemPhoto,
      };
}
