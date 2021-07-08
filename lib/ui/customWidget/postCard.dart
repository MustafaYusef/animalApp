import 'package:animal_app/data/allPostRes.dart';
import 'package:animal_app/data/myPostModel.dart';
import 'package:animal_app/ui/screens/myPosts/PostDetailsScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/constant.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/ui/screens/sectionItemsScreen.dart';

import 'loadingImage.dart';

class postCard extends StatelessWidget {
  AllPost? item;
  postCard([this.item]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(item!.id);
        Get.to(PostDetailsScreen(item));
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: Get.width / 2,
              height: 250,
              imageUrl: imageUrl + item!.photo!,
              placeholder: (context, url) => loadinImage(),
              errorWidget: (context, url, error) => loadinImage(),
            ),
            Container(
              // height: 250,
              // width: Get.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[300]!),
                          color: Get.theme.accentColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 20,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        item!.likesCount.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Get.theme.accentColor,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Directionality(
                            child: Text(
                              item!.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
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
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 2,
        margin: EdgeInsets.all(5),
      ),
    );
  }
}
