
// import 'package:flutter/material.dart';

// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:get/get.dart';

// OperationPopUp() {
//   // TextEditingController text = TextEditingController();

//   // print("time ....  " + dateTimeNow.toString());
//   var alertStyle = AlertStyle(
//     // animationType: AnimationType.fromTop,
//     isCloseButton: true,
//     isOverlayTapDismiss: true,

//     descStyle: TextStyle(fontWeight: FontWeight.bold),
//     // descTextAlign: TextAlign.start,
//     overlayColor: Get.theme.primaryColor.withOpacity(0.5),
//     alertPadding: EdgeInsets.all(10),
//     buttonAreaPadding: EdgeInsets.all(10),
//     animationDuration: Duration(milliseconds: 200),
//     alertBorder: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20.0),
//       side: BorderSide(
//         color: Colors.grey,
//       ),
//     ),
//     titleStyle: TextStyle(color: Colors.black, fontSize: 20),
//     buttonsDirection: ButtonsDirection.column,
//     alertAlignment: Alignment.center,
//   );

//   Alert(
//       style: alertStyle,
//       context: Get.context,
//       type: AlertType.none,
//       title: getTranslate("selectOperation"),
//       buttons: [
//         DialogButton(
//           color: Get.theme.primaryColor,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.all(10),
//           radius: BorderRadius.circular(10),
//           onPressed: () => null,
//           child: InkWell(
//             onTap: () async {
//               Get.back();
//               Get.to(AddItemsReport(res));
//             },
//             child: Container(
//               height: 70,
//               width: Get.width - 150,
//               child: Center(
//                 child: Text(
//                   "report",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ).tr(),
//               ),
//             ),
//           ),
//         ),
//         DialogButton(
//           color: Get.theme.primaryColor,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.all(10),
//           radius: BorderRadius.circular(10),
//           onPressed: () => null,
//           child: InkWell(
//             onTap: () async {
//               Get.back();
//               Get.to(AddOrderScreen(res));
//             },
//             child: Container(
//               height: 50,
//               width: Get.width - 150,
//               child: Center(
//                 child: Text(
//                   "order",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ).tr(),
//               ),
//             ),
//           ),
//         ),
//         DialogButton(
//           color: Get.theme.primaryColor,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.all(10),
//           radius: BorderRadius.circular(10),
//           onPressed: () => null,
//           child: InkWell(
//             onTap: () async {
//               Get.back();
//               Get.to(MarketingActivityScreen(
//                 reource: res,
//               ));
//             },
//             child: Container(
//               height: 50,
//               width: Get.width - 150,
//               child: Center(
//                 child: Text(
//                   "marketing",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ).tr(),
//               ),
//             ),
//           ),
//         ),
//         DialogButton(
//           color: Get.theme.primaryColor,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.all(10),
//           radius: BorderRadius.circular(10),
//           onPressed: () => null,
//           child: InkWell(
//             onTap: () async {
//               Get.back();
//               Get.to(NextVisitScreen(
//                 reource: res,
//               ));
//             },
//             child: Container(
//               height: 50,
//               width: Get.width - 150,
//               child: Center(
//                 child: Text(
//                   "nextVisit",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ).tr(),
//               ),
//             ),
//           ),
//         ),
//         DialogButton(
//           color: Get.theme.primaryColor,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.all(10),
//           radius: BorderRadius.circular(10),
//           onPressed: () => null,
//           child: InkWell(
//             onTap: () async {
//               Get.back();
//               Get.to(CollectionScreen(
//                 reource: res,
//               ));
//             },
//             child: Container(
//               height: 50,
//               width: Get.width - 150,
//               child: Center(
//                 child: Text(
//                   "collection",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ).tr(),
//               ),
//             ),
//           ),
//         ),
//         DialogButton(
//           color: Get.theme.primaryColor,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.all(10),
//           radius: BorderRadius.circular(10),
//           onPressed: () => null,
//           child: InkWell(
//             onTap: () async {
//               Get.back();
//               Get.to(ReturnOrderScreen(res));
//             },
//             child: Container(
//               height: 50,
//               width: Get.width - 150,
//               child: Center(
//                 child: Text(
//                   "returnOrder",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ).tr(),
//               ),
//             ),
//           ),
//         )
//       ]).show();
// }
