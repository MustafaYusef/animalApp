// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:animal_app/controller/mainController/favouriteController.dart';
// import 'package:animal_app/controller/mainController/itemDetailsController.dart';
// import 'package:animal_app/data/itemDetails.dart';
// import 'package:animal_app/ui/screens/imagesDetailsScreen.dart';

// import '../../constant.dart';
// import 'loadingImage.dart';

// class sliderItemDetails extends StatelessWidget {
//   sliderItemDetails({
//     Key key,
//     @required this.controller,
//     @required this.favouriteController,
//     @required this.image,
//   });

//   final ItemDetailsController controller;
//   String image;
//   final FavouriteController favouriteController;

//   @override
//   Widget build(BuildContext context) {
//     void onPageChange(int index, CarouselPageChangedReason changeReason) {
//       controller.current.value = index;
//     }

//     return Obx(
//       () => Container(
//         height: (MediaQuery.of(context).size.height / 2) + 50,
//         child: Stack(children: <Widget>[
//           Container(
//             child: CarouselSlider.builder(
//               itemCount: controller.itemDetails.value.color.length == 0
//                   ? 1
//                   : controller.itemDetails.value.color.length,
//               options: CarouselOptions(
//                 height: (MediaQuery.of(context).size.height / 2) + 50,
//                 viewportFraction: 1.0,
//                 enableInfiniteScroll: true,
//                 autoPlay: false,
//                 aspectRatio: 2.0,
//                 autoPlayInterval: Duration(seconds: 3),
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 pauseAutoPlayOnTouch: true,
//                 enlargeCenterPage: true,
//                 onPageChanged: onPageChange,
//                 scrollDirection: Axis.horizontal,
//               ),
//               itemBuilder: (BuildContext context, int itemIndex, int i) =>
//                   itemIndex == controller.itemDetails.value.color.length
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(0),
//                           child: InkWell(
//                               onTap: () {
//                                 Get.to(ImagesScreenDetails(
//                                     controller: controller));
//                               },
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Card(
//                                   semanticContainer: true,
//                                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                                   child: Stack(
//                                     children: [
//                                       CachedNetworkImage(
//                                         fit: BoxFit.cover,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         height: (MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 2) +
//                                             40,
//                                         imageUrl: controller.itemDetails.value
//                                                     .color.length ==
//                                                 0
//                                             ? "s"
//                                             : imageUrl + image,
//                                         placeholder: (context, url) =>
//                                             loadinImage(),
//                                         errorWidget: (context, url, error) =>
//                                             loadinImage(),
//                                       ),
//                                     ],
//                                   ),
//                                   // shape: RoundedRectangleBorder(
//                                   //   borderRadius:
//                                   //       BorderRadius.circular(0.0),
//                                   // ),
//                                   elevation: 0,
//                                 ),
//                               )),
//                         )
//                       : ClipRRect(
//                           borderRadius: BorderRadius.circular(0),
//                           child: InkWell(
//                               onTap: () {
//                                 Get.to(ImagesScreenDetails(
//                                     controller: controller));
//                               },
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Card(
//                                   semanticContainer: true,
//                                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                                   child: Stack(
//                                     children: [
//                                       CachedNetworkImage(
//                                         fit: BoxFit.cover,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         height: (MediaQuery.of(context)
//                                                     .size
//                                                     .height /
//                                                 2) +
//                                             40,
//                                         imageUrl: controller.itemDetails.value
//                                                     .color.length ==
//                                                 0
//                                             ? "s"
//                                             : imageUrl +
//                                                 controller
//                                                     .itemDetails
//                                                     .value
//                                                     .color[controller
//                                                         .current.value]
//                                                     .photo,
//                                         placeholder: (context, url) =>
//                                             loadinImage(),
//                                         errorWidget: (context, url, error) =>
//                                             loadinImage(),
//                                       ),
//                                     ],
//                                   ),
//                                   // shape: RoundedRectangleBorder(
//                                   //   borderRadius:
//                                   //       BorderRadius.circular(0.0),
//                                   // ),
//                                   elevation: 0,
//                                 ),
//                               )),
//                         ),
//             ),
//           ),
//           Positioned(
//               bottom: 0.0,
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 10),
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: controller.itemDetails.value.color.map((image) {
//                     return Container(
//                       width: 12.0,
//                       height: 8.0,
//                       margin:
//                           EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: controller.current.value ==
//                                   controller.itemDetails.value.color
//                                       .indexOf(image)
//                               ? Colors.deepOrange
//                               : Colors.white),
//                     );
//                   }).toList(),
//                 ),
//               )),
//           Positioned(
//               top: 30.0,
//               right: 10.0,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();

//                       String token = await prefs.getString('token');
//                       if (token != null) {
//                         int id = 0;
//                         if (favouriteController.favouriteList.value.any((e) =>
//                             e.items.id == controller.itemDetails.value.id)) {
//                           print("yes");
//                           id = favouriteController.favouriteList.value
//                               .indexWhere((e) =>
//                                   e.items.id == controller.itemDetails.value.id)
//                               .toInt();
//                           favouriteController.deleteFavourite(
//                               favouriteController.favouriteList.value[id].id);
//                         } else {
//                           print("no");

//                           favouriteController
//                               .addFavourite(controller.itemDetails.value.id);
//                         }
//                       } else {
//                         Get.snackbar("يجب تسجيل الدخول", "يجب تسجيل الدخول",
//                             duration: Duration(seconds: 3),
//                             icon: Icon(
//                               Icons.info,
//                               color: Colors.white,
//                             ),
//                             colorText: Colors.white,
//                             backgroundColor:
//                                 Get.theme.primaryColorDark.withOpacity(0.3));
//                       }
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 10),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(22.5)),
//                           color: Colors.white),
//                       width: 45,
//                       height: 45,
//                       child: Center(
//                           child: favouriteController.favouriteList.value.any(
//                                   (e) =>
//                                       e.items.id ==
//                                       controller.itemDetails.value.id)
//                               ? Icon(
//                                   Icons.favorite,
//                                   size: 25,
//                                   color: Colors.red[600],
//                                 )
//                               : Icon(
//                                   Icons.favorite_border,
//                                   size: 25,
//                                 )),
//                     ),
//                   ),
//                 ],
//               ))
//         ]),
//       ),
//     );
//   }
// }
