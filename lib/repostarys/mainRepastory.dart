import 'dart:convert';

import 'package:animal_app/data/myBookingServices.dart';
import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/data/servicesModel.dart';
import 'package:http/http.dart';
// import 'package:animal_app/data/AllitemsModel.dart';
import 'package:animal_app/data/addRes.dart';
import 'package:animal_app/data/bannersModel.dart';
import 'package:animal_app/data/cartModel.dart';
import 'package:animal_app/data/checkPromoRes.dart';
import 'package:animal_app/data/favouriteModel.dart';
import 'package:animal_app/data/itemDetails.dart';
import 'package:animal_app/data/itemsPagination.dart';
import 'package:animal_app/data/loginModel.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/data/profileModel.dart';
import 'package:animal_app/data/shippingPrice.dart';
import 'package:animal_app/data/testModel.dart';

import '../constant.dart';

class MainRepostary {
  // Future<List<Welcome>> getMyTask(int page, int limit) async {
  //   final response = await get(
  //       "https://5f7cba02834b5c0016b058aa.mockapi.io/api/users?page=$page&limit=$limit");
  //   if (response.statusCode == 200) {
  //     return welcomeFromJson(response.body);
  //   } else if (response.statusCode == 401) {
  //     throw Exception(response.statusCode);
  //   } else {
  //     throw Exception('حدث خطأ ما');
  //   }
  // }

  Future<BannersModel> getFirstBanner() async {
    final response = await get(baseUrl + "dashbord/banners");
    if (response.statusCode == 200) {
      return bannersModelFromJson(response.body);
    } else {
      throw Exception(bannersModelFromJson(response.body).message);
    }
  }

  Future<BannersModel> getSecondBanner() async {
    final response = await get(baseUrl + "dashbord/bannersb");
    if (response.statusCode == 200) {
      return bannersModelFromJson(response.body);
    } else {
      throw Exception(bannersModelFromJson(response.body).message);
    }
  }

  // status 0== offers
  // status 1==popular
  Future<OfferPopularItemsModel> getOfferOrPopularItems(
      int status, int page, int limit) async {
    final response = await get(
        baseUrl + "items/offers/all?page=$page&limit=$limit&status=$status");
    if (response.statusCode == 200) {
      return offerPopularItemsModelFromJson(response.body);
    } else {
      throw Exception(offerPopularItemsModelFromJson(response.body).message);
    }
  }

  Future<MyPetsModel> getMyPets(String token) async {
    final response = await get(baseUrl + "users/pet/my/all",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return myPetsModelFromJson(response.body);
    } else {
      throw Exception(myPetsModelFromJson(response.body).message);
    }
  }

  Future<MainCategoryModel> getMainCategory() async {
    final response = await get(baseUrl + "category/mains");
    if (response.statusCode == 200) {
      return mainCategoryModelFromJson(response.body);
    } else {
      throw Exception(mainCategoryModelFromJson(response.body).message);
    }
  }

  Future<ItemsPaginationModel> getCategoryItem(
      int categoryId, int page, int limit) async {
    final response = await get(baseUrl +
        "customers/category?category_id=$categoryId&page=$page&limit=$limit");
    if (response.statusCode == 200) {
      return itemsPaginationModelFromJson(response.body);
    } else {
      throw Exception(itemsPaginationModelFromJson(response.body).message);
    }
  }

// nuill all
// 0=false
// 1=true
  Future<ServicesModel> getServices(int in_house) async {
    final response =
        await get(baseUrl + "dashbord/services/all?in_house=$in_house");
    if (response.statusCode == 200) {
      return servicesModelFromJson(response.body);
    } else {
      throw Exception(servicesModelFromJson(response.body).message);
    }
  }

  Future<MyBookingModel> getMyBooking(String token, int page, int limit) async {
    final response = await get(
        baseUrl + "users/booking/my?page=$page&limit=$limit",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return myBookingModelFromJson(response.body);
    } else {
      throw Exception(myBookingModelFromJson(response.body).message);
    }
  }

  Future<ItemDetailsModel> getItemDetaild(int id) async {
    final response = await get(baseUrl + "items/item/$id");
    if (response.statusCode == 200) {
      return itemDetailsModelFromJson(response.body);
    } else {
      throw Exception(itemDetailsModelFromJson(response.body).message);
    }
  }

  Future<AddResModel> addFavourite(int id, String token) async {
    final response = await post(baseUrl + "users/favorite/$id",
        headers: {"Authorization": token});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(addResModelFromJson(response.body).data.msg);
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).data.msg);
    }
  }

  Future<AddResModel> deleteFavourite(int id, String token) async {
    print(token);
    final response = await delete(baseUrl + "users/favorite/$id",
        headers: {"Authorization": token, "Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<FavouriteModel> getFavourite(String token) async {
    final response = await get(baseUrl + "users/favorite/my",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return favouriteModelFromJson(response.body);
    } else {
      throw Exception(favouriteModelFromJson(response.body).statusCode);
    }
  }

  Future<MyOrderModel> getOrder(String token, int page, int limit) async {
    final response = await get(
        baseUrl + "orders/orders/my?page=$page&limit=$limit",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return myOrderModelFromJson(response.body);
    } else {
      throw Exception(myOrderModelFromJson(response.body).statusCode);
    }
  }

  Future<ShippingPriceRes> getShipingPrice(String token) async {
    final response =
        await get(baseUrl + "users/shpinng", headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return shippingPriceResFromJson(response.body);
    } else {
      throw Exception(shippingPriceResFromJson(response.body).statusCode);
    }
  }

  Future<AddResModel> cancelOrder(String token, int id) async {
    final response = await delete(baseUrl + "orders/order/$id",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).statusCode);
    }
  }

  Future<AddResModel> addCart(int size_id, int count, String token) async {
    print(token);
    final response = await post(baseUrl + "users/cart/add",
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: json.encode(
            {"item_id": size_id.toString(), "count": count.toString()}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<AddResModel> bookServices(
      {String token,
      String type,
      String phone,
      String pet,
      String address,
      String notes,
      int service_id}) async {
    print(token);
    final response = await post(baseUrl + "users/booking/new",
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: json.encode({
          "type": type,
          "phone": phone,
          "pet": pet,
          "notes": notes,
          "address": address,
          "service_id": service_id.toString()
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<AddResModel> addPets(
      {String token,
      String type,
      String pet,
      String base64,
      String age,
        String desc,
      int sex,
      String last_vaccine}) async {
    print(token);
    final response = await post(baseUrl + "users/pet/add",
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: json.encode({
          "type": type,
          "name": pet,
          "age": age,
          "sex": sex,
          "base64": base64,
          "last_vaccine": last_vaccine,
          "description": desc
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<AddResModel> makeOrder(
      String token,
      String name,
      String phone,
      String government,
      String city,
      String address,
      int shippingPrice,
      String promo) async {
    print(token);
    final response = await post(baseUrl + "orders/new",
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: json.encode({
          "name": name,
          "phone": phone,
          "government": government,
          "city": city,
          "address": address,
          "shpping_price": shippingPrice.toString(),
          "promo": promo
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<CheckPromoModel> checkPromo(String token, String promo) async {
    print(token);
    final response = await post(baseUrl + "customers/promo/check",
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: json.encode({"promo": promo}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return checkPromoModelFromJson(response.body);
    } else {
      throw Exception(checkPromoModelFromJson(response.body).message);
    }
  }

  Future<AddResModel> deleteCart(int id, String token) async {
    final response = await delete(baseUrl + "users/cart/$id",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return addResModelFromJson(response.body);
    } else {
      throw Exception(addResModelFromJson(response.body).message);
    }
  }

  Future<CartModel> getCart(String token) async {
    final response =
        await get(baseUrl + "users/cart", headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return cartModelFromJson(response.body);
    } else {
      throw Exception(cartModelFromJson(response.body).message);
    }
  }
}
