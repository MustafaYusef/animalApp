// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// MyBookingModel myBookingModelFromJson(String str) =>
//     MyBookingModel.fromJson(json.decode(str));

// class MyBookingModel {
//   MyBookingModel({
//     this.statusCode,
//     this.message,
//     this.data,
//   });

//   int statusCode;
//   String message;
//   Data data;

//   factory MyBookingModel.fromJson(Map<String, dynamic> json) => MyBookingModel(
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
//     this.myList,
//     this.limit,
//     this.totalItems,
//     this.totalpages,
//     this.pages,
//   });

//   List<MyList> myList;
//   int limit;
//   int totalItems;
//   int totalpages;
//   int pages;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         myList:
//             List<MyList>.from(json["my_list"].map((x) => MyList.fromJson(x))),
//         limit: json["limit"],
//         totalItems: json["totalItems"],
//         totalpages: json["totalpages"],
//         pages: json["pages"],
//       );

//   Map<String, dynamic> toJson() => {
//         "my_list": List<dynamic>.from(myList.map((x) => x.toJson())),
//         "limit": limit,
//         "totalItems": totalItems,
//         "totalpages": totalpages,
//         "pages": pages,
//       };
// }

// class MyList {
//   MyList({
//     this.id,
//     this.status,
//     this.type,
//     this.pet,
//     this.address,
//     this.phone,
//     this.price,
//     this.notes,
//     this.visitAt,
//     this.updatedAt,
//     this.createdAt,
//     this.services,
//   });

//   int id;
//   int status;
//   String type;
//   String pet;
//   String address;
//   String phone;
//   String price;
//   String notes;
//   String visitAt;
//   DateTime updatedAt;
//   DateTime createdAt;
//   Services services;

//   factory MyList.fromJson(Map<String, dynamic> json) => MyList(
//         id: json["id"],
//         status: json["status"],
//         type: json["type"],
//         pet: json["pet"],
//         address: json["address"],
//         phone: json["phone"],
//         price: json["price"],
//         notes: json["notes"],
//         visitAt: json["visit_at"],
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         services: Services.fromJson(json["services"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "status": status,
//         "type": type,
//         "pet": pet,
//         "address": address,
//         "phone": phone,
//         "price": price,
//         "notes": notes,
//         "visit_at": visitAt,
//         "updatedAt": updatedAt.toIso8601String(),
//         "createdAt": createdAt.toIso8601String(),
//         "services": services.toJson(),
//       };
// }

// class Services {
//   Services({
//     this.id,
//     this.name,
//     this.inHouse,
//     this.photo,
//   });

//   int id;
//   String name;
//   int inHouse;
//   String photo;

//   factory Services.fromJson(Map<String, dynamic> json) => Services(
//         id: json["id"],
//         name: json["name"],
//         inHouse: json["in_house"],
//         photo: json["photo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "in_house": inHouse,
//         "photo": photo,
//       };
// }
// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MyBookingModel myBookingModelFromJson(String str) =>
    MyBookingModel.fromJson(json.decode(str));

class MyBookingModel {
  MyBookingModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory MyBookingModel.fromJson(Map<String, dynamic> json) => MyBookingModel(
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
    this.myList,
    this.limit,
    this.totalItems,
    this.totalpages,
    this.pages,
  });

  List<MyList> myList;
  int limit;
  int totalItems;
  int totalpages;
  int pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myList:
            List<MyList>.from(json["my_list"].map((x) => MyList.fromJson(x))),
        limit: json["limit"],
        totalItems: json["totalItems"],
        totalpages: json["totalpages"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "my_list": List<dynamic>.from(myList.map((x) => x.toJson())),
        "limit": limit,
        "totalItems": totalItems,
        "totalpages": totalpages,
        "pages": pages,
      };
}

class MyList {
  MyList({
    this.id,
    this.status,
    this.address,
    this.phone,
    this.price,
    this.notes,
    this.visitAt,
    this.updatedAt,
    this.createdAt,
    this.services,
    this.pet,
  });

  int id;
  int status;
  String address;
  String phone;
  String price;
  String notes;
  String visitAt;
  DateTime updatedAt;
  DateTime createdAt;
  Services services;
  Pet pet;

  factory MyList.fromJson(Map<String, dynamic> json) => MyList(
        id: json["id"],
        status: json["status"],
        address: json["address"],
        phone: json["phone"],
        price: json["price"],
        notes: json["notes"],
        visitAt: json["visit_at"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        services: Services.fromJson(json["services"]),
        pet: json["pet"] == null ? null : Pet.fromJson(json["pet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "address": address,
        "phone": phone,
        "price": price,
        "notes": notes,
        "visit_at": visitAt,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "services": services.toJson(),
        "pet": pet == null ? null : pet.toJson(),
      };
}

class Pet {
  Pet({
    this.id,
    this.name,
    this.type,
    this.age,
    this.sex,
    this.softDelete,
    this.description,
    this.lastVaccine,
    this.photo,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  String name;
  String type;
  DateTime age;
  int sex;
  bool softDelete;
  String description;
  String lastVaccine;
  String photo;
  DateTime updatedAt;
  DateTime createdAt;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        age: DateTime.parse(json["age"]),
        sex: json["sex"],
        softDelete: json["softDelete"],
        description: json["description"],
        lastVaccine: json["last_vaccine"],
        photo: json["photo"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "age": age.toIso8601String(),
        "sex": sex,
        "softDelete": softDelete,
        "description": description,
        "last_vaccine": lastVaccine,
        "photo": photo,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class Services {
  Services({
    this.id,
    this.name,
    this.inHouse,
    this.photo,
  });

  int id;
  String name;
  int inHouse;
  String photo;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        id: json["id"],
        name: json["name"],
        inHouse: json["in_house"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "in_house": inHouse,
        "photo": photo,
      };
}
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// MyBookingModel myBookingModelFromJson(String str) =>
//     MyBookingModel.fromJson(json.decode(str));

// class MyBookingModel {
//   MyBookingModel({
//     this.statusCode,
//     this.message,
//     this.data,
//   });

//   int statusCode;
//   String message;
//   Data data;

//   factory MyBookingModel.fromJson(Map<String, dynamic> json) => MyBookingModel(
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
//     this.myList,
//     this.limit,
//     this.totalItems,
//     this.totalpages,
//     this.pages,
//   });

//   List<MyList> myList;
//   int limit;
//   int totalItems;
//   int totalpages;
//   int pages;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         myList:
//             List<MyList>.from(json["my_list"].map((x) => MyList.fromJson(x))),
//         limit: json["limit"],
//         totalItems: json["totalItems"],
//         totalpages: json["totalpages"],
//         pages: json["pages"],
//       );

//   Map<String, dynamic> toJson() => {
//         "my_list": List<dynamic>.from(myList.map((x) => x.toJson())),
//         "limit": limit,
//         "totalItems": totalItems,
//         "totalpages": totalpages,
//         "pages": pages,
//       };
// }

// class MyList {
//   MyList({
//     this.id,
//     this.status,
//     this.address,
//     this.phone,
//     this.price,
//     this.notes,
//     this.visitAt,
//     this.updatedAt,
//     this.createdAt,
//     this.services,
//     // this.pet,
//   });

//   int id;
//   int status;
//   String address;
//   String phone;
//   String price;
//   String notes;
//   String visitAt;
//   DateTime updatedAt;
//   DateTime createdAt;
//   Services services;
//   // Pet pet;

//   factory MyList.fromJson(Map<String, dynamic> json) => MyList(
//         id: json["id"],
//         status: json["status"],
//         address: json["address"],
//         phone: json["phone"],
//         price: json["price"],
//         notes: json["notes"],
//         visitAt: json["visit_at"],
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         services: Services.fromJson(json["services"]),
//         // pet: Pet.fromJson(json["pet"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "status": status,
//         "address": address,
//         "phone": phone,
//         "price": price,
//         "notes": notes,
//         "visit_at": visitAt,
//         "updatedAt": updatedAt.toIso8601String(),
//         "createdAt": createdAt.toIso8601String(),
//         "services": services.toJson(),
//         // "pet": pet.toJson(),
//       };
// }

// // class Pet {
// //   Pet({
// //     this.id,
// //     this.name,
// //     // this.type,
// //     // this.age,
// //     // this.sex,
// //     // this.softDelete,
// //     // this.description,
// //     // // this.lastVaccine,
// //     // this.photo,
// //     // this.updatedAt,
// //     // this.createdAt,
// //   });

// //   int id;
// //   String name;
// //   // String type;
// //   // DateTime age;
// //   // int sex;
// //   // bool softDelete;
// //   // String description;
// //   // // String lastVaccine;
// //   // String photo;
// //   // DateTime updatedAt;
// //   // DateTime createdAt;

// //   factory Pet.fromJson(Map<String, dynamic> json) => Pet(
// //         id: json["id"],
// //         name: json["name"],
// //         // type: json["type"],
// //         // age: DateTime.parse(json["age"]),
// //         // sex: json["sex"],
// //         // softDelete: json["softDelete"],
// //         // description: json["description"],
// //         // // lastVaccine: json["last_vaccine"],
// //         // photo: json["photo"],
// //         // updatedAt: DateTime.parse(json["updatedAt"]),
// //         // createdAt: DateTime.parse(json["createdAt"]),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "name": name,
// //         // "type": type,
// //         // "age": age.toIso8601String(),
// //         // "sex": sex,
// //         // "softDelete": softDelete,
// //         // "description": description,
// //         // // "last_vaccine": lastVaccine,
// //         // "photo": photo,
// //         // "updatedAt": updatedAt.toIso8601String(),
// //         // "createdAt": createdAt.toIso8601String(),
// //       };
// // }

// class Services {
//   Services({
//     this.id,
//     this.name,
//     this.inHouse,
//     this.photo,
//   });

//   int id;
//   String name;
//   int inHouse;
//   String photo;

//   factory Services.fromJson(Map<String, dynamic> json) => Services(
//         id: json["id"],
//         name: json["name"],
//         inHouse: json["in_house"],
//         photo: json["photo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "in_house": inHouse,
//         "photo": photo,
//       };
// }
