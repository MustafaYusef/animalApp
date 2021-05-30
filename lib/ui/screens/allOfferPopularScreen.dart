import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/popularOfferController.dart';
import 'package:animal_app/ui/customWidget/itemCard.dart';
import 'package:animal_app/ui/customWidget/itemCardAllOffer.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';

class AllOfferPopularScreen extends StatelessWidget {
  OfferPopularController controller;
  int status;
  AllOfferPopularScreen(this.status) {
    controller = Get.put(OfferPopularController());
    controller.status.value = status;
    controller.getPopolarOfffer();
  }
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!controller.isLoading.value) {
            if (!controller.lastPage.value) {
              controller.getPopolarOfffer();
            }
          }
        }
      });
    return WillPopScope(
      onWillPop: () {
        Get.delete<OfferPopularController>();
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            status == 0 ? "أخر العروض" : "العناصر الشائعة",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            child: Container(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => controller.itemsOffPop.isEmpty
                      ? Container(
                          child: Center(
                            child: controller.noNetFlage.value
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      NoInternetWidget(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.page.value = 1;
                                          controller.itemsOffPop.clear();
                                          controller.lastPage.value = false;
                                          return controller.getPopolarOfffer();
                                        },
                                        child: Text(
                                          "إعادة المحاولة",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    child: controller.isEmptyFlage.value
                                        ? Text("لا يوجد عناصر لديك")
                                        : Container(
                                            height: Get.height,
                                            width: Get.width,
                                            child: Center(
                                              child: Container(
                                                  child: circularProgress()),
                                            ),
                                          )),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: Container(
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    controller.page.value = 1;
                                    controller.itemsOffPop.clear();
                                    controller.lastPage.value = false;
                                    return controller.getPopolarOfffer();
                                  },
                                  child: ListView.builder(
                                    itemCount: controller.itemsOffPop.length,
                                    itemBuilder: (context, index) {
                                      return itemCardAll(
                                        controller.itemsOffPop[index],
                                      );
                                    },
                                    scrollDirection: Axis.vertical,

                                    controller: _scrollController,

                                    // children: controller.itemsOffPop
                                    //     .map((e) {})
                                    //     .toList()
                                  ),
                                ),
                              ),
                            ),
                            !controller.isLoading.value
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 20,
                                          height: 20,
                                          color: Colors.transparent,
                                          margin: EdgeInsets.only(
                                              bottom: 20, top: 10),
                                          child: Theme(
                                            data: ThemeData(
                                                accentColor:
                                                    Get.theme.primaryColor,
                                                primaryColor:
                                                    Get.theme.primaryColor),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )),
                                    ],
                                  )
                          ],
                        ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
