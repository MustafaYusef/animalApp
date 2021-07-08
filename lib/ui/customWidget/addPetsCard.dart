import 'package:animal_app/ui/screens/authScreen/loginScreen.dart';
import 'package:animal_app/ui/screens/authScreen/regesterSceen.dart';
import 'package:animal_app/ui/screens/pets/addPetScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPetsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            height: 120,
            width: Get.width / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[300]!),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                String? token = prefs.getString('token');
                if (token == null) {
                  Get.to(RegesterScreen());
                } else {
                  Get.to(AddPetsScreen());
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
