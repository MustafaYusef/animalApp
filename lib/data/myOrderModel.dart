// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyOrderModel myOrderModelFromJson(String str) =>
    MyOrderModel.fromJson(json.decode(str));

class MyOrderModel {
  MyOrderModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
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
    this.myOrders,
    this.limit,
    this.totalItems,
    this.totalpages,
    this.pages,
  });

  List<MyOrder> myOrders;
  int limit;
  int totalItems;
  int totalpages;
  int pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myOrders: List<MyOrder>.from(
            json["my_orders"].map((x) => MyOrder.fromJson(x))),
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalpages: json["totalpages"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "my_orders": List<dynamic>.from(myOrders.map((x) => x.toJson())),
        "limit": limit,
        "totalItems": totalItems,
        "totalpages": totalpages,
        "pages": pages,
      };
}

class MyOrder {
  MyOrder({
    this.id,
    this.name,
    this.phone,
    this.city,
    this.government,
    this.address,
    this.status,
    this.price,
    this.updatedAt,
    this.createdAt,
    this.shpping_price,
    this.orderItems,
  });

  int id;
  String name;
  String phone;
  String city;
  String government;
  String address;
  int status;
  int price;
  String updatedAt;
  String createdAt;
  int shpping_price;
  List<OrderItem> orderItems;

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        city: json["city"],
        government: json["government"],
        address: json["address"],
        status: json["status"],
        price: json["price"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"],
        shpping_price: json["shpping_price"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "city": city,
        "government": government,
        "address": address,
        "status": status,
        "price": price,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "shpping_price": shpping_price,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.name,
    this.description,
    this.covePhoto,
    this.color,
    this.size,
    this.isOffer,
    this.count,
  });

  int id;
  String name;
  String description;
  String covePhoto;
  String color;
  String size;
  bool isOffer;
  int count;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        covePhoto: json["cove_photo"],
        color: json["color"],
        size: json["size"],
        isOffer: json["is_offer"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "cove_photo": covePhoto,
        "color": color,
        "size": size,
        "is_offer": isOffer,
        "count": count,
      };
}
