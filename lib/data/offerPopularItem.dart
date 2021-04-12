// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OfferPopularItemsModel offerPopularItemsModelFromJson(String str) =>
    OfferPopularItemsModel.fromJson(json.decode(str));

class OfferPopularItemsModel {
  OfferPopularItemsModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory OfferPopularItemsModel.fromJson(Map<String, dynamic> json) =>
      OfferPopularItemsModel(
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
    this.items,
    this.limit,
    this.totalItems,
    this.totalpages,
    this.pages,
  });

  List<ItemOffer> items;
  int limit;
  int totalItems;
  int totalpages;
  int pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<ItemOffer>.from(
            json["items"].map((x) => ItemOffer.fromJson(x))),
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalpages: json["totalpages"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "limit": limit,
        "totalItems": totalItems,
        "totalpages": totalpages,
        "pages": pages,
      };
}

class ItemOffer {
  ItemOffer({
    this.id,
    this.name,
    this.softDelete,
    this.description,
    this.price,
    this.buyed,
    this.offerPrice,
    this.offer,
    this.has_count,
    this.barcode,
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
  bool has_count;

  String barcode;
  String covePhoto;

  DateTime updatedAt;
  DateTime createdAt;

  factory ItemOffer.fromJson(Map<String, dynamic> json) => ItemOffer(
        id: json["id"],
        name: json["name"],
        softDelete: json["softDelete"],
        description: json["description"],
        price: json["price"],
        buyed: json["buyed"],
        offerPrice: json["offer_price"],
        offer: json["offer"],
        has_count: json["has_count"],
        barcode: json["barcode"],
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
        "has_count": has_count,
        "barcode": barcode,
        "cove_photo": covePhoto,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
