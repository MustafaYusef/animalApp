import 'package:flutter/material.dart';
import 'package:get/get.dart';

class loadinImage extends StatelessWidget {
  const loadinImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Container(
            width: 25,
            height: 25,
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(
                  accentColor: Get.theme.primaryColor,
                  primaryColor: Get.theme.primaryColor),
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )),
      ),
    );
  }
}
