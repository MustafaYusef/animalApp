// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ItemDetailsModel itemDetailsModelFromJson(String str) =>
    ItemDetailsModel.fromJson(json.decode(str));

class ItemDetailsModel {
  ItemDetailsModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory ItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      ItemDetailsModel(
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

  ItemDetails item;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: ItemDetails.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
      };
}

class ItemDetails {
  ItemDetails({
    this.id,
    this.name,
    this.description,
    this.price,
    this.offerPrice,
    this.offer,
    this.covePhoto,
    this.color,
  });

  int id;
  String name;
  String description;
  int price;
  int offerPrice;
  bool offer;
  String covePhoto;
  List<ColorItem> color;

  factory ItemDetails.fromJson(Map<String, dynamic> json) => ItemDetails(
        id: json["id"],
        name: json["name"],
        description: json["body"],
        price: json["price"],
        offerPrice: json["offer_price"],
        offer: json["offer"],
        covePhoto: json["cove_photo"],
        color: List<ColorItem>.from(
            json["color"].map((x) => ColorItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "body": description,
        "price": price,
        "offer_price": offerPrice,
        "offer": offer,
        "cove_photo": covePhoto,
        "color": List<dynamic>.from(color.map((x) => x.toJson())),
      };
}

class ColorItem {
  ColorItem({
    this.id,
    this.name,
    this.photo,
    this.size,
  });

  int id;
  String name;
  String photo;
  List<SizeItem> size;

  factory ColorItem.fromJson(Map<String, dynamic> json) => ColorItem(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        size:
            List<SizeItem>.from(json["size"].map((x) => SizeItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
      };
}

class SizeItem {
  SizeItem({
    this.id,
    this.name,
    this.count,
  });

  int id;
  String name;
  int count;

  factory SizeItem.fromJson(Map<String, dynamic> json) => SizeItem(
        id: json["id"],
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
      };
}
