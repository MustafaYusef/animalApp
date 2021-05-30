// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ReviewCheckModel reviewCheckModelFromJson(String str) =>
    ReviewCheckModel.fromJson(json.decode(str));

class ReviewCheckModel {
  ReviewCheckModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory ReviewCheckModel.fromJson(Map<String, dynamic> json) =>
      ReviewCheckModel(
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
    this.reviewCheck,
  });

  ReviewCheck reviewCheck;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reviewCheck: ReviewCheck.fromJson(json["review_check"]),
      );

  Map<String, dynamic> toJson() => {
        "review_check": reviewCheck.toJson(),
      };
}

class ReviewCheck {
  ReviewCheck({
    this.id,
    this.inReview,
  });

  int id;
  bool inReview;

  factory ReviewCheck.fromJson(Map<String, dynamic> json) => ReviewCheck(
        id: json["id"],
        inReview: json["in_review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "in_review": inReview,
      };
}
