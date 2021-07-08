import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/constant.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/ui/screens/sectionItemsScreen.dart';

import 'loadingImage.dart';

class sectionCard extends StatelessWidget {
  MainCategory? item;
  sectionCard([this.item]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(item!.id);
        Get.to(SectionsItemScreen(item));
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: Get.width / 2.5,
              height: 130,
              imageUrl: imageUrl + item!.photo!,
              placeholder: (context, url) => loadinImage(),
              errorWidget: (context, url, error) => loadinImage(),
            ),
            Container(
              height: 130,
              width: Get.width / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Directionality(
                      child: Text(
                        item!.name!,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0.5,
                        1
                      ],
                      colors: [
                        Colors.black26.withOpacity(0.3),
                        Colors.transparent
                      ])),
            ),
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
