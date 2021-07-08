import 'package:animal_app/data/itemsPagination.dart';
import 'package:animal_app/ui/screens/itemDetailsScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/constant.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:animal_app/metods/methods.dart';

import 'loadingImage.dart';

class orderItemCard extends StatelessWidget {
  OrderItem? item;
  orderItemCard([this.item]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(ItemDetailsScreen(Item(
        //     id: item.id,
        //     name: item.name,
        //     description: item.description,
        //     offer: item.isOffer,
        //     offerPrice: 0,
        //     count: item.count,
        //     covePhoto: item.covePhoto,
        //     price: item.price)));
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
              imageUrl: imageUrl + item!.covePhoto.toString(),
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
                      item!.name!,
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
                              "العدد : " + item!.count.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ).addDirectionality(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
