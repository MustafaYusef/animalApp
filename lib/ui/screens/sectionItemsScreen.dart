import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/itemsSectionController.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/data/offerPopularItem.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/customWidget/favouriteItemCard.dart';
import 'package:animal_app/ui/customWidget/itemCard.dart';
import 'package:animal_app/ui/customWidget/itemMainCard.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/sectionCard2.dart';
import 'package:animal_app/ui/customWidget/subCategoryCard.dart';

class SectionsItemScreen extends StatefulWidget {
  final MainCategory? section;
  SectionsItemScreen(this.section);

  @override
  _SectionsItemScreenState createState() => _SectionsItemScreenState();
}

class _SectionsItemScreenState extends State<SectionsItemScreen> {
  SectionsItemsController _controller = Get.put(SectionsItemsController());

  @override
  void initState() {
    print("category id    " + widget.section!.id.toString());
    _controller.id.value = widget.section!.id!;
    _controller.isMainLoading.value = true;

    _controller.getSubCategory();
    super.initState();
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!_controller.isLoading.value) {
            if (!_controller.lastPage.value) {
              _controller.isLoading.value = true;
              _controller.getSubCategory();
            }
          }
        }
      });
    Future<bool> _wiilPop() async {
      Get.delete<SectionsItemsController>();
      Get.back();
      return true;
    }

    return WillPopScope(
      onWillPop: _wiilPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.section!.name!,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ).addDirectionality(),
        ),
        body: Obx(
          () => Container(
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
                                  _controller.getSubCategory();
                                },
                                child: Text(
                                  "إعادة المحاولة",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    ))
                : Container(
                    child: _controller.isMainLoading.value
                        ? Container(
                            width: Get.width,
                            height: Get.height,
                            child: Center(
                              child: Container(
                                height: Get.height,
                                width: Get.width,
                                child: Center(
                                  child: Container(child: circularProgress()),
                                ),
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              height: Get.height - 120,
                              child: Column(children: [
                                Expanded(
                                  child: _controller.sectionsList.value.data!
                                          .subCategory!.isEmpty
                                      ? Column(
                                          children: [
                                            Expanded(
                                              child: RefreshIndicator(
                                                onRefresh: () {
                                                  _controller.page.value = 1;
                                                  _controller.itemsOffPop
                                                      .clear();
                                                  _controller.lastPage.value =
                                                      false;
                                                  return _controller
                                                      .getSubCategory();
                                                },
                                                child: ListView.builder(
                                                  itemCount: _controller
                                                      .itemsOffPop.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return itemMainCard(
                                                        _controller.itemsOffPop[
                                                            index]);
                                                  },
                                                  scrollDirection:
                                                      Axis.vertical,

                                                  controller: _scrollController,

                                                  // children: controller.itemsOffPop
                                                  //     .map((e) {})
                                                  //     .toList()
                                                ),
                                              ),
                                            ),
                                            !_controller.isLoading.value
                                                ? Container()
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          width: 20,
                                                          height: 20,
                                                          color: Colors
                                                              .transparent,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20,
                                                                  top: 10),
                                                          child: Theme(
                                                            data: ThemeData(
                                                                accentColor: Get
                                                                    .theme
                                                                    .primaryColor,
                                                                primaryColor: Get
                                                                    .theme
                                                                    .primaryColor),
                                                            child:
                                                                CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                            ),
                                                          )),
                                                    ],
                                                  )
                                          ],
                                        )
                                      : RefreshIndicator(
                                          onRefresh: () {
                                            // _controller.page.value = 1;
                                            // _controller.itemsOffPop.clear();
                                            // _controller.lastPage.value = false;
                                            return _controller.getSubCategory();
                                          },
                                          child: ListView.builder(
                                            itemCount: _controller
                                                .sectionsList
                                                .value
                                                .data!
                                                .subCategory!
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return SubCategoryCard(_controller
                                                  .sectionsList
                                                  .value
                                                  .data!
                                                  .subCategory![index]);
                                            },
                                          ),
                                        ),
                                )
                              ]),
                            ),
                          )),
          ),
        ),
      ),
    );
  }
}
