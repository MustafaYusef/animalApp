import 'package:flutter/material.dart';
import 'package:get/get.dart';
class popUpLoading extends StatelessWidget {
  const popUpLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Theme(
            data: ThemeData(
                primaryColor: Get.theme.primaryColorDark,
                accentColor: Get.theme.primaryColorDark),
            child: CircularProgressIndicator()));
  }
}
