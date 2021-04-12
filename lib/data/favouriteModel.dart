// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FavouriteModel favouriteModelFromJson(String str) => FavouriteModel.fromJson(json.decode(str));


class FavouriteModel {
    FavouriteModel({
        this.statusCode,
        this.message,
        this.data,
    });

    int statusCode;
    String message;
    Data data;

    factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
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
        this.myFavorite,
    });

    List<MyFavorite> myFavorite;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        myFavorite: List<MyFavorite>.from(json["my_favorite"].map((x) => MyFavorite.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "my_favorite": List<dynamic>.from(myFavorite.map((x) => x.toJson())),
    };
}

class MyFavorite {
    MyFavorite({
        this.id,
        this.items,
    });

    int id;
    Items items;

    factory MyFavorite.fromJson(Map<String, dynamic> json) => MyFavorite(
        id: json["id"],
        items: Items.fromJson(json["items"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "items": items.toJson(),
    };
}

class Items {
    Items({
        this.id,
        this.name,
        this.softDelete,
        this.description,
        this.price,
        this.buyed,
        this.offerPrice,
        this.offer,
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
    String barcode;
    String covePhoto;
    DateTime updatedAt;
    DateTime createdAt;

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["id"],
        name: json["name"],
        softDelete: json["softDelete"],
        description: json["description"],
        price: json["price"],
        buyed: json["buyed"],
        offerPrice: json["offer_price"],
        offer: json["offer"],
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
        "barcode": barcode,
        "cove_photo": covePhoto,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
