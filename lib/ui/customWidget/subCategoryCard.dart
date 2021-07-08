import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/constant.dart';
import 'package:animal_app/controller/mainController/itemsSectionController.dart';
// import 'package:animal_app/data/categoryItems.dart';
import 'package:animal_app/data/itemsPagination.dart';
import 'package:animal_app/data/mainCategoryModel.dart';
import 'package:animal_app/ui/customWidget/loadingImage.dart';
import 'package:animal_app/ui/screens/sectionItemsScreen.dart';

class SubCategoryCard extends StatelessWidget {
  SubCategory item;
  SubCategoryCard(this.item);
  SectionsItemsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("here iam mother fucker");
        // _controller.sectionsList.value = null;
        _controller.isMainLoading.value = true;
        _controller.id.value = item.id!;
        _controller.itemsOffPop.clear();
        _controller.page.value = 1;
        _controller.getSubCategory();
      },
      child: Card(
        color: Get.theme.primaryColor,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Directionality(
                          child: Text(
                            item.name!,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                elevation: 5,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  width: 90,
                  height: 90,
                  imageUrl: imageUrl + item.photo!,
                  placeholder: (context, url) => loadinImage(),
                  errorWidget: (context, url, error) => loadinImage(),
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(7),
      ),
    );
  }
}
