import 'package:animal_app/data/makeOrderModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';
import 'package:animal_app/metods/extentions.dart';
import '../constant.dart';
import '../ui/customWidget/loadingImage.dart';

GiftPopUp(GiftItem? item) {
  // TextEditingController text = TextEditingController();
  var alertStyle = AlertStyle(
    // animationType: AnimationType.fromTop,
    isCloseButton: true,
    isOverlayTapDismiss: true,

    descStyle: TextStyle(fontWeight: FontWeight.bold),
    // descTextAlign: TextAlign.start,
    alertPadding: EdgeInsets.all(5),
    buttonAreaPadding: EdgeInsets.all(5),
    animationDuration: Duration(milliseconds: 200),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.black,
    ),
    animationType: AnimationType.grow,
    alertAlignment: Alignment.center,
  );

  Alert(
      style: alertStyle,
      context: Get.context!,
      type: AlertType.none,
      title: "لديك هدية مجانية",
      closeFunction: () {
        Get.back();
      },
      content: Container(
          width: Get.width,
          height: Get.height - 200,
          child: Column(
            children: [
              Container(
                  width: Get.width / 2,
                  height: 400,
                  child: Lottie.asset(
                    'assets/images/gift_json.json',
                    width: Get.width / 2,
                    height: 400,
                    repeat: true,
                    fit: BoxFit.contain,
                  )),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: (Get.width / 3) - 10,
                          height: 120,
                          imageUrl: imageUrl + item!.covePhoto.toString(),
                          placeholder: (context, url) => loadinImage(),
                          errorWidget: (context, url, error) => loadinImage(),
                        ),
                        if (item.count != 0)
                          Container()
                        else
                          Container(
                            child: Container(
                              width: (Get.width / 3) - 10,
                              height: 120,
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
                              item.name!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                                      item.offer!
                                          ? item.offerPrice.toString() +
                                              " " +
                                              "د.ع"
                                          : item.price.toString() + " " + "د.ع",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ).addDirectionality(),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    item.offer!
                                        ? Text(
                                            item.price.toString(),
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
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
                  ],
                ).addDirectionality(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(4),
              )
            ],
          )),
      buttons: [
        DialogButton(
          color: Get.theme.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          radius: BorderRadius.circular(20),
          onPressed: () => null,
          child: InkWell(
            onTap: () async {
              Get.back();
            },
            child: Container(
              height: 50,
              width: Get.width - 200,
              child: Center(
                child: Text(
                  "تم",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ).addDirectionality(),
              ),
            ),
          ),
        )
      ]).show();
}
