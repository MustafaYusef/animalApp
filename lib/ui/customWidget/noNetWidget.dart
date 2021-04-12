import 'package:flutter/material.dart';
import 'package:animal_app/metods/extentions.dart';

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
          Image.asset("assets/images/no_wifi.png",
              width: MediaQuery.of(context).size.width - 250,
              alignment: Alignment.center,
              fit: BoxFit.cover),
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
