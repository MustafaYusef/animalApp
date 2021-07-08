// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AddResModel addResModelFromJson(String str) => AddResModel.fromJson(json.decode(str));


class AddResModel {
    AddResModel({
        this.statusCode,
        this.message,
        this.data,
    });

    int? statusCode;
    String? message;
    Data? data;

    factory AddResModel.fromJson(Map<String, dynamic> json) => AddResModel(
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
        this.msg,
    });

    String? msg;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
    };
}
