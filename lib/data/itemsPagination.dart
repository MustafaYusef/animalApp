// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ItemsPaginationModel itemsPaginationModelFromJson(String str) =>
    ItemsPaginationModel.fromJson(json.decode(str));

class ItemsPaginationModel {
  ItemsPaginationModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory ItemsPaginationModel.fromJson(Map<String, dynamic> json) =>
      ItemsPaginationModel(
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
    this.paginationItems,
    this.subCategory,
  });

  PaginationItems? paginationItems;
  List<SubCategory>? subCategory;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paginationItems: PaginationItems.fromJson(json["pagination_items"]),
        subCategory: List<SubCategory>.from(
            json["subCategory"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination_items": paginationItems!.toJson(),
        "subCategory": List<dynamic>.from(subCategory!.map((x) => x.toJson())),
      };
}

// class Data {
//   Data({
//     this.items,
//     this.subCategory,
//   });

//   List<Item> items;
//   List<SubCategory> subCategory;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
//         subCategory: List<SubCategory>.from(
//             json["subCategory"].map((x) => SubCategory.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "items": List<dynamic>.from(items.map((x) => x.toJson())),
//         "subCategory": List<dynamic>.from(subCategory.map((x) => x.toJson())),
//       };
// }

class PaginationItems {
  PaginationItems({
    this.items,
    this.limit,
    this.totalItems,
    this.totalpages,
    this.pages,
  });

  List<Item>? items;
  int? limit;
  int? totalItems;
  int? totalpages;
  int? pages;

  factory PaginationItems.fromJson(Map<String, dynamic> json) =>
      PaginationItems(
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalpages: json["totalpages"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "Items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "limit": limit,
        "totalItems": totalItems,
        "totalpages": totalpages,
        "pages": pages,
      };
}

class Item {
  Item({
    this.id,
    this.name,
    this.description,
    this.price,
    this.offerPrice,
    this.offer,
    this.count,
    this.covePhoto,
  });

  int? id;
  String? name;
  String? description;
  int? price;
  int? offerPrice;
  bool? offer;
  int? count;
  String? covePhoto;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        offerPrice: json["offer_price"],
        offer: json["offer"],
        count: json["count"],
        covePhoto: json["cove_photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "offer_price": offerPrice,
        "offer": offer,
        "count": count,
        "cove_photo": covePhoto,
      };
}

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.photo,
  });

  int? id;
  String? name;
  String? photo;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
      };
}
