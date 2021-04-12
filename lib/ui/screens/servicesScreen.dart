import 'package:animal_app/controller/servicesController.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "الأقسام",
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
              : Container(
                  child: _controller.sectionsList.value == null
                      ? Container(
                          width: Get.width,
                          height: Get.height,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          child: _controller
                                  .sectionsList.value.data.services.isEmpty
                              ? Container(
                                  width: Get.width,
                                  height: Get.height,
                                  child: Center(
                                    child: Text("لا يوجد بيانات"),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: GetPlatform.isIOS
                                            ? Get.height - 180
                                            : Get.height - 110,
                                        child: Column(children: [
                                          Expanded(
                                            child: RefreshIndicator(
                                              onRefresh: () {
                                                return _controller
                                                    .getSections(inHouse);
                                              },
                                              child: ListView.builder(
                                                itemCount: _controller
                                                    .sectionsList
                                                    .value
                                                    .data
                                                    .services
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return servicesCard(
                                                      _controller
                                                          .sectionsList
                                                          .value
                                                          .data
                                                          .services[index]);
                                                },
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                        )),
        ),
      ),
    );
  }
}
