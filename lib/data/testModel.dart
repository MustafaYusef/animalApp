//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));


class Welcome {
    Welcome({
        this.id,
        this.name,
        this.username,
        this.userTypes,
    });

    String id;
    String name;
    String username;
    List<UserType> userTypes;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        userTypes: List<UserType>.from(json["user_types"].map((x) => UserType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "user_types": List<dynamic>.from(userTypes.map((x) => x.toJson())),
    };
}

class UserType {
    UserType({
        this.id,
        this.userId,
        this.name,
    });

    String id;
    String userId;
    String name;

    factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
    };
}
