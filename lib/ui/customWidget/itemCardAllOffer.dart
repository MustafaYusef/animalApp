import 'package:animal_app/controller/mainController/favouriteController.dart';
import 'package:animal_app/data/itemsPagination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/itemDetailsScreen.dart';
import '../../constant.dart';
import 'loadingImage.dart';

class itemCardAll extends StatelessWidget {
  ItemOffer item;
  itemCardAll(this.item);
  FavouriteController favouriteController = Get.find();

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
            count: 0,
            covePhoto: item.covePhoto,
            price: item.price)));
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                width: (Get.width / 3) - 10,
                height: 110,
                imageUrl: imageUrl + item.covePhoto,
                placeholder: (context, url) => loadinImage(),
                errorWidget: (context, url, error) => loadinImage(),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                // width: Get.width,
                height: 85,
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ).addDirectionality(),
                        Expanded(child: Container()),
                        // Container(
                        //     child: InkWell(
                        //   onTap: () async {
                        //     if (favouriteController
                        //         .favouriteList.value.data.myFavorite
                        //         .contains(item)) {
                        //       print("yes");

                        //       // favouriteController.deleteFavourite(item.id);
                        //     } else {
                        //       print("no");

                        //       favouriteController.addFavourite(item.id);
                        //     }
                        //   },
                        //   child: Container(
                        //     margin: EdgeInsets.all(5),
                        //     decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(17.5)),
                        //         color: Colors.white.withOpacity(0.4)),
                        //     width: 35,
                        //     height: 35,
                        //     child: Center(
                        //         child: favouriteController
                        //                 .favouriteList.value.data.myFavorite
                        //                 .contains(item)
                        //             ? Icon(
                        //                 Icons.favorite,
                        //                 size: 25,
                        //                 color: Colors.red[600],
                        //               )
                        //             : Icon(
                        //                 Icons.favorite_border,
                        //                 size: 25,
                        //                 color: Colors.grey[700],
                        //               )),
                        //   ),
                        // ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.offer
                                  ? item.offerPrice.toString() + " " + "د.ع"
                                  : item.price.toString() + " " + "د.ع",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ).addDirectionality(),
                            SizedBox(
                              width: 5,
                            ),
                            item.offer
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
                        // item.items.offer
                        //     ? Container(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 3, vertical: 2),
                        //         decoration: BoxDecoration(
                        //             color: Get.theme.primaryColorLight),
                        //         child: Text(
                        //           (((item.items.price - item.items.offerPrice) /
                        //                       item.items.price *
                        //                       100))
                        //                   .toInt()
                        //                   .toString() +
                        //               "%",
                        //           style: TextStyle(fontSize: 12),
                        //         ),
                        //       )
                        //     : Container()
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Container(
                    //       child: item.items.offer
                    //           ? Container(
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 3, vertical: 2),
                    //               decoration: BoxDecoration(
                    //                   color: Get.theme.primaryColorLight),
                    //               child: Text(
                    //                 (((item.items.price -
                    //                                 item.items.offerPrice) /
                    //                             item.items.price *
                    //                             100))
                    //                         .toInt()
                    //                         .toString() +
                    //                     "%",
                    //                 style: TextStyle(fontSize: 12),
                    //               ),
                    //             )
                    //           : Container(),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            )
          ],
        ).addDirectionality(),
        elevation: 5,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
