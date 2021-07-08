// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyPostModel myPostModelFromJson(String str) =>
    MyPostModel.fromJson(json.decode(str));

class MyPostModel {
  MyPostModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory MyPostModel.fromJson(Map<String, dynamic> json) => MyPostModel(
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
    this.myPosts,
    this.limit,
    this.totalItems,
    this.totalpages,
    this.pages,
  });

  List<MyPost>? myPosts;
  int? limit;
  int? totalItems;
  int? totalpages;
  int? pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myPosts:
            List<MyPost>.from(json["my_posts"].map((x) => MyPost.fromJson(x))),
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalpages: json["totalpages"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "my_posts": List<dynamic>.from(myPosts!.map((x) => x.toJson())),
        "limit": limit,
        "totalItems": totalItems,
        "totalpages": totalpages,
        "pages": pages,
      };
}

class MyPost {
  MyPost({
    this.id,
    this.likesCount,
    this.allowed,
    this.description,
    this.photo,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  int? likesCount;
  bool? allowed;
  String? description;
  String? photo;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory MyPost.fromJson(Map<String, dynamic> json) => MyPost(
        id: json["id"],
        likesCount: json["likes_count"],
        allowed: json["allowed"],
        description: json["description"],
        photo: json["photo"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "likes_count": likesCount,
        "allowed": allowed,
        "description": description,
        "photo": photo,
        "updatedAt": updatedAt!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
      };
}
