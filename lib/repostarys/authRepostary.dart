import 'dart:convert';

import 'package:http/http.dart';
import 'package:animal_app/data/addRes.dart';
import 'package:animal_app/data/loginModel.dart';
import 'package:animal_app/data/profileModel.dart';

import '../constant.dart';

class AuthRepostary {
  Future<LoginModel> Login(
      String phone, String password, String player_id) async {
    final response = await post(baseUrl + "users/auth/login",
        headers: {"Content-Type": "application/json"},
        body: json.encode(
            {"phone": phone, "password": password, "player_id": player_id}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return loginModelFromJson(response.body);
    } else if (response.statusCode == 403) {
      throw Exception(loginModelFromJson(response.body).message);
    } else {
      print(loginModelFromJson(response.body).statusCode);
      throw Exception(loginModelFromJson(response.body).statusCode);
    }
  }

  Future<ProfileModel> getProfile(String token) async {
    final response = await get(baseUrl + "users/auth/profile",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return profileModelFromJson(response.body);
    } else if (response.statusCode == 403) {
      throw Exception(profileModelFromJson(response.body).statusCode);
    } else {
      throw Exception(profileModelFromJson(response.body).message);
    }
  }

  Future<void> Regester(
      String name, String phone, String password, String player_id) async {
    final response = await post(baseUrl + "users/auth/register",
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "phone": phone,
          "password": password,
          "player_id": player_id,
          "name": name,
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<void> SendEmail(String email) async {
    final response = await post(baseUrl + "users/auth/mail/send",
        // headers: {"Content-Type": "application/json"},
        body: ({"email": email}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(addResModelFromJson(response.body).data.msg);
      return;
    } else {
      print("faillllllllllll");
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<void> resetPassword(String email, String code, String password) async {
    final response = await post(baseUrl + "users/auth/password/reset",
        headers: {"Content-Type": "application/json"},
        body:
            json.encode({"email": email, "code": code, "password": password}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<void> updateProfile(
    String token,
    String name,
    String phone,
  ) async {
    final response = await put(baseUrl + "users/auth/proile/edit",
        headers: {"Authorization": token},
        body: ({"phone": phone, "name": name}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }
}
