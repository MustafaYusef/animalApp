import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/data/itemsPagination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/itemDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import 'loadingImage.dart';

class itemCard extends StatelessWidget {
  ItemOffer item;
  itemCard(this.item, this.favouriteController, this.cartController);
  FavouriteController favouriteController;
  ItemDetailsController cartController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ItemDetailsScreen(Item(
            id: item.id,
            name: item.name,
            description: item.description,
            offer: item.offer,
            offerPrice: item.offerPrice,
            count: item.count,
            covePhoto: item.covePhoto,
            price: item.price)));
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 150,
                        height: 140,
                        imageUrl: imageUrl + item.covePhoto!,
                        placeholder: (context, url) => loadinImage(),
                        errorWidget: (context, url, error) => loadinImage(),
                      ),
                      if (item.count != 0)
                        Container()
                      else
                        Container(
                          child: Container(
                            width: 150,
                            height: 140,
                            child: Center(
                              child: Text(
                                "غير متوفر",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                    ],
                  ),
                ),
                Obx(
                  () => favouriteController.needLogin.value ||
                          favouriteController.isLoading.value
                      ? Container()
                      : Positioned(
                          top: 10.0,
                          right: 20.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  String? token =
                                      await prefs.getString('token');
                                  if (token != null) {
                                    int id = 0;
                                    if (favouriteController
                                        .favouriteList.value.data!.myFavorite!
                                        .any((e) => e.items!.id == item.id)) {
                                      print("yes");
                                      id = favouriteController
                                          .favouriteList.value.data!.myFavorite!
                                          .indexWhere(
                                              (e) => e.items!.id == item.id)
                                          .toInt();
                                      print(id);
                                      favouriteController.deleteFavourite(
                                          favouriteController.favouriteList
                                              .value.data!.myFavorite![id].id);
                                    } else {
                                      print("no");

                                      favouriteController.addFavourite(item.id);
                                    }
                                  } else {
                                    Get.snackbar(
                                        "يجب تسجيل الدخول", "يجب تسجيل الدخول",
                                        duration: Duration(seconds: 3),
                                        icon: Icon(
                                          Icons.info,
                                          color: Colors.white,
                                        ),
                                        colorText: Colors.white,
                                        backgroundColor: Get
                                            .theme.primaryColorDark
                                            .withOpacity(0.3));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22.5)),
                                      color: Colors.grey),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                      child: favouriteController.favouriteList
                                              .value.data!.myFavorite!
                                              .any(
                                                  (e) => e.items!.id == item.id)
                                          ? Icon(
                                              Icons.favorite,
                                              size: 25,
                                              color: Colors.red[600],
                                            )
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                              size: 25,
                                            )),
                                ),
                              ),
                            ],
                          )),
                ),
                // if (item.has_count == null)
                //   Container()
                // else
                //   Container(
                //     child: item.has_count
                //         ? Container()
                //         : Container(
                //             width: (Get.width / 2.5) + 10,
                //             height: 160,
                //             child: Center(
                //               child: Text(
                //                 "غير متوفر حالياً",
                //                 style: TextStyle(
                //                     color: Colors.black, fontSize: 18),
                //               ),
                //             ),
                //             decoration: BoxDecoration(
                //                 color: Colors.white.withOpacity(0.6),
                //                 borderRadius: BorderRadius.circular(5)),
                //           ),
                //   )
              ],
            ),
            Container(
              width: 150,
              height: 105,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: item.name!.length > 10 ? 14 : 18,
                        fontWeight: FontWeight.bold),
                  ).addDirectionality(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            item.offer!
                                ? item.offerPrice.toString() + " " + "د.ع"
                                : item.price.toString() + " " + "د.ع",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ).addDirectionality(),
                          SizedBox(
                            width: 5,
                          ),
                          item.offer!
                              ? Text(
                                  item.price.toString(),
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ).addDirectionality()
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (item.count == 0)
                        Container()
                      else
                        Container(
                            child: InkWell(
                          onTap: () async {
                            cartController.count.value = 1;
                            cartController.addCart(item.id);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Get.theme.accentColor),
                            width: 40,
                            height: 30,
                            child: Center(
                                child: Image.asset(
                                    "assets/images/carrt_icon.png")),
                          ),
                        )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
