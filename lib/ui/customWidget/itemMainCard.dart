import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:animal_app/data/categoryItems.dart';
import 'package:animal_app/data/itemsPagination.dart';

import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/itemDetailsScreen.dart';

import '../../constant.dart';
import 'loadingImage.dart';

class itemMainCard extends StatelessWidget {
  Item item;
  itemMainCard(this.item);
  ItemDetailsController favouriteController = Get.find();

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: (Get.width / 3) - 10,
              height: 120,
              imageUrl: imageUrl + item.covePhoto.toString(),
              placeholder: (context, url) => loadinImage(),
              errorWidget: (context, url, error) => loadinImage(),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                width: Get.width / 2.5,
                height: 100,
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    child: InkWell(
                  onTap: () async {
                    favouriteController.addCart(item.id);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Get.theme.accentColor),
                    width: 50,
                    height: 35,
                    child: Center(
                        child: Image.asset("assets/images/carrt_icon.png")),
                  ),
                )),
              ],
            ),
          ],
        ).addDirectionality(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
