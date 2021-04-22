import 'package:animal_app/data/servicesModel.dart';
import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';
import 'package:animal_app/ui/screens/authScreen/regesterSceen.dart';
import 'package:animal_app/ui/screens/bookingScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/constant.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/ui/screens/sectionItemsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loadingImage.dart';

class servicesCard extends StatelessWidget {
  Service item;
  servicesCard([this.item]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String token = prefs.getString('token');
        if (token == null) {
          Get.to(RegesterScreen());
        } else {
          Get.to(BookingScreen(item));
        }
      },
      child: Card(
        color: Get.theme.accentColor,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Directionality(
                          child: Text(
                            item.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Directionality(
                              child: Text(
                                item.cost,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                elevation: 5,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                  imageUrl: imageUrl + item.photo,
                  placeholder: (context, url) => loadinImage(),
                  errorWidget: (context, url, error) => loadinImage(),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
