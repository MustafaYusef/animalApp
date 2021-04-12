import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/constant.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:animal_app/metods/methods.dart';

class orderItemCard extends StatelessWidget {
  OrderItem item;
  orderItemCard([this.item]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(SectionsItemScreen(item));
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Directionality(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            item.count.toString(),
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ).addDirectionality(),
                          Text(
                            "الكمية  : ",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ).addDirectionality(),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: getColorFromColorCode(item.color),
                              //color: widget.color[index],
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: 25,
                            height: 25,
                          ),
                          Text(
                            "اللون  : ",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ).addDirectionality(),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            item.size.toString(),
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ).addDirectionality(),
                          Text(
                            "الحجم  : ",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ).addDirectionality(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: Get.width / 3,
              height: 120,
              imageUrl: imageUrl + item.covePhoto,
              placeholder: (context, url) => Image.asset(
                "assets/images/placeholder.png",
                width: Get.width / 2.5,
                height: 110,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/placeholder.png",
                width: Get.width / 2.5,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 3,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
