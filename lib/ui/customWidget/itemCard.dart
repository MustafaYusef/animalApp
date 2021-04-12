import 'package:animal_app/data/itemsPagination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/itemDetailsScreen.dart';
import '../../constant.dart';
import 'loadingImage.dart';

class itemCard extends StatelessWidget {
  ItemOffer item;
  itemCard(this.item);
  // FavouriteController favouriteController = Get.find();

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
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: (Get.width / 2.5) + 10,
                  height: 160,
                  imageUrl: imageUrl + item.covePhoto,
                  placeholder: (context, url) => loadinImage(),
                  errorWidget: (context, url, error) => loadinImage(),
                ),
                if (item.has_count == null)
                  Container()
                else
                  Container(
                    child: item.has_count
                        ? Container()
                        : Container(
                            width: (Get.width / 2.5) + 10,
                            height: 160,
                            child: Center(
                              child: Text(
                                "غير متوفر حالياً",
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
            Container(
              width: Get.width / 2.5,
              height: 80,
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ).addDirectionality(),
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
                                fontSize: 16,
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: item.offer
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2),
                                decoration:
                                    BoxDecoration(color: Get.theme.accentColor),
                                child: Text(
                                  (((item.price - item.offerPrice) /
                                              item.price *
                                              100))
                                          .toInt()
                                          .toString() +
                                      "%",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 2,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
