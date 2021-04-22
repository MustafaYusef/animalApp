import 'package:animal_app/controller/servicesController.dart';
import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/servicesCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/metods/extentions.dart';

class ServicesScreen extends StatelessWidget {
  int inHouse;
  ServicesScreen(this.inHouse) {
    _controller = Get.put(ServicesController());
    _controller.sectionsList.value = null;
    _controller.getSections(inHouse);
  }
  ServicesController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "الخدمات المتوفرة",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ).addDirectionality(),
      ),
      body: Obx(
        () => Container(
          height: Get.height,
          child: _controller.noNetFlage.value
              ? Container(
                  height: Get.height,
                  child: Column(
                    children: [
                      Expanded(
                          child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NoInternetWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                _controller.getSections(inHouse);
                              },
                              child: Text(
                                "إعادة المحاولة",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ))
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                          child: _controller.sectionsList.value == null
                              ? Container(
                                  width: Get.width,
                                  height: Get.height,
                                  child: Center(
                                    child: Container(
                                      height: Get.height / 2,
                                      width: Get.width,
                                      child: Center(
                                        child: Container(
                                            child: circularProgress()),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: _controller.sectionsList.value.data
                                          .services.isEmpty
                                      ? Container(
                                          width: Get.width,
                                          height: Get.height,
                                          child: Center(
                                            child: Text("لا يوجد بيانات"),
                                          ),
                                        )
                                      : RefreshIndicator(
                                          onRefresh: () {
                                            return _controller
                                                .getSections(inHouse);
                                          },
                                          child: ListView.builder(
                                            itemCount: _controller.sectionsList
                                                .value.data.services.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return servicesCard(_controller
                                                  .sectionsList
                                                  .value
                                                  .data
                                                  .services[index]);
                                            },
                                          ),
                                        ),
                                )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
