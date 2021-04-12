// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
// import 'package:responsive_grid/responsive_grid.dart';
// import 'package:tipaFasion/controller/testController.dart';
// import 'package:tipaFasion/data/testModel.dart';
// import 'package:tipaFasion/ui/customWidget/sectionCard.dart';
// import 'package:tipaFasion/ui/screens/itemDetailsScreen.dart';

// import '../../constant.dart';

// class CollectionScreen extends StatelessWidget {
//   CollectionScreen({Key key}) : super(key: key);
//   var listImage = [
//     "https://img.freepik.com/free-photo/pretty-young-stylish-sexy-woman-pink-luxury-dress-summer-fashion-trend-chic-style-sunglasses-blue-studio-background-shopping-holding-paper-bags-talking-mobile-phone-shopaholic_285396-2957.jpg?size=626&ext=jpg",
//     "https://thumbs.dreamstime.com/b/portrait-pretty-woman-sunglasses-hat-over-blue-colorful-portrait-pretty-woman-sunglasses-hat-over-blue-103615694.jpg",
//     "https://assets.vogue.com/photos/5f5fac8b7d9362f52d645560/16:9/w_1280,c_limit/social-holding.jpg"
//   ];
//   HomeController _controller = Get.put(HomeController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "الأقسام",
//           style: TextStyle(
//               fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//           child: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height - 150,
//           child: Column(
//             children: [
//               Expanded(
//                 child: Obx(
//                   () => LazyLoadScrollView(
//                     onEndOfPage: _controller.loadNextPage,
//                     isLoading: _controller.lastPage,
//                     child: ResponsiveGridList(
//                         desiredItemWidth:
//                             (MediaQuery.of(context).size.width / 2) - 10,
//                         minSpacing: 5,
//                         children: _controller.users.map((data) {
//                           return Container();
//                         }).toList()),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
