import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/ui/screens/pets/petsDetailsScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import 'loadingImage.dart';

class PetsCard extends StatelessWidget {
  MyPet myPet;
  PetsCard(this.myPet);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(PetsDetailsScreen(myPet));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 170,
        width: Get.width / 3.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
          color: Get.theme.primaryColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 20,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: 60,
                height: 60,
                imageUrl: imageUrl + myPet.photo!,
                placeholder: (context, url) => loadinImage(),
                errorWidget: (context, url, error) => loadinImage(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              myPet.name.toString(),
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
