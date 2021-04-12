import 'package:animal_app/data/itemsPagination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/data/cartModel.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/screens/itemDetailsScreen.dart';

import '../../constant.dart';
import 'loadingImage.dart';

class CartitemCard extends StatelessWidget {
  MyCart item;
  CartitemCard(this.item);
  ItemDetailsController favouriteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ItemDetailsScreen(Item(
            id: item.itemId,
            name: item.itemName,
            description: item.itemDescription,
            offer: item.offer,
            offerPrice: item.itemOfferPrice,
            count: item.count,
            covePhoto: item.itemPhoto,
            price: item.itemPrice)));
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
              imageUrl: imageUrl + item.itemPhoto.toString(),
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
                      item.itemName,
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
                                  ? item.itemOfferPrice.toString() + " " + "د.ع"
                                  : item.itemPrice.toString() + " " + "د.ع",
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
                                    item.itemPrice.toString(),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    child: InkWell(
                  onTap: () async {
                    favouriteController.deleteCart(item.id);
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white.withOpacity(0.9)),
                    width: 40,
                    height: 40,
                    child: Center(
                        child: Icon(
                      Icons.delete,
                      size: 25,
                      color: Get.theme.accentColor,
                    )),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[300]),
                      // color: Get.theme.accentColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (favouriteController.countArray[
                                    favouriteController
                                        .cartModel.value.data.myCart
                                        .indexOf(item)] >
                                1) {
                              favouriteController.countArray[favouriteController
                                  .cartModel.value.data.myCart
                                  .indexOf(item)]--;
                              favouriteController.updateCart(
                                  item.itemId,
                                  favouriteController.countArray[
                                      favouriteController
                                          .cartModel.value.data.myCart
                                          .indexOf(item)]);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "-",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          child: Obx(
                            () => Text(
                              favouriteController.countArray[favouriteController
                                      .cartModel.value.data.myCart
                                      .indexOf(item)]
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // if (controller.count.value <
                            //     controller.selectedSize.value.count) {
                            // favouriteController.count.value++;
                            favouriteController.countArray[favouriteController
                                .cartModel.value.data.myCart
                                .indexOf(item)]++;
                            favouriteController.updateCart(
                                item.itemId,
                                favouriteController.countArray[
                                    favouriteController
                                        .cartModel.value.data.myCart
                                        .indexOf(item)]);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "+",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
