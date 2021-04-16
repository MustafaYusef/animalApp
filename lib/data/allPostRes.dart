// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AllPostModel allPostModelFromJson(String str) =>
    AllPostModel.fromJson(json.decode(str));

class AllPostModel {
  AllPostModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory AllPostModel.fromJson(Map<String, dynamic> json) => AllPostModel(
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
    this.allPosts,
    this.limit,
    this.totalItems,
    this.totalpages,
    this.pages,
  });

  List<AllPost> allPosts;
  int limit;
  int totalItems;
  int totalpages;
  int pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        allPosts: List<AllPost>.from(
            json["all_posts"].map((x) => AllPost.fromJson(x))),
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalpages: json["totalpages"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "all_posts": List<dynamic>.from(allPosts.map((x) => x.toJson())),
        "limit": limit,
        "totalItems": totalItems,
        "totalpages": totalpages,
        "pages": pages,
      };
}

class AllPost {
  AllPost({
    this.id,
    this.likesCount,
    this.allowed,
    this.description,
    this.photo,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  int likesCount;
  bool allowed;
  String description;
  String photo;
  DateTime updatedAt;
  DateTime createdAt;

  factory AllPost.fromJson(Map<String, dynamic> json) => AllPost(
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
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
