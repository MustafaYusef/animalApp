import 'package:flutter/material.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:get/get.dart';

class NoInternetWidget extends StatefulWidget {
  @override
  _NoInternetWidgetState createState() => new _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            color: Get.theme.primaryColor,
            size: 150,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "لا يوجد اتصال بالشبكة",
            style: TextStyle(
              fontSize: 16,
            ),
          ).addDirectionality(),
        ],
      ),
    );
  }
}
