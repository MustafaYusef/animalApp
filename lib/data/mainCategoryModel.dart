// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// MainCategoryModel mainCategoryModelFromJson(String str) =>
//     MainCategoryModel.fromJson(json.decode(str));

// class MainCategoryModel {
//   MainCategoryModel({
//     this.statusCode,
//     this.message,
//     this.data,
//   });

//   int statusCode;
//   String message;
//   Data data;

//   factory MainCategoryModel.fromJson(Map<String, dynamic> json) =>
//       MainCategoryModel(
//         statusCode: json["statusCode"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   Data({
//     this.categories,
//   });

//   List<MainCategory> categories;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         categories: List<MainCategory>.from(
//             json["categories"].map((x) => MainCategory.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//       };
// }

// class MainCategory {
//   MainCategory({
//     this.id,
//     this.name,
//     this.photo,
//   });

//   int id;
//   String name;
//   String photo;

//   factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
//         id: json["id"],
//         name: json["name"],
//         photo: json["photo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "photo": photo,
//       };
// }
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MainCategoryModel mainCategoryModelFromJson(String str) =>
    MainCategoryModel.fromJson(json.decode(str));

class MainCategoryModel {
  MainCategoryModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory MainCategoryModel.fromJson(Map<String, dynamic> json) =>
      MainCategoryModel(
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
    this.categories,
  });

  List<MainCategory>? categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<MainCategory>.from(
            json["categories"].map((x) => MainCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class MainCategory {
  MainCategory({
    this.id,
    this.name,
    this.nameEn,
    this.photo,
  });

  int? id;
  String? name;
  String? nameEn;
  String? photo;

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_en": nameEn,
        "photo": photo,
      };
}
