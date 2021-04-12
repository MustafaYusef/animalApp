// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';

// EnableGpsPop(contex2) {
//   // TextEditingController text = TextEditingController();
//   // print("time ....  " + dateTimeNow.toString());
//   var alertStyle = AlertStyle(
//     // animationType: AnimationType.fromTop,
//     isCloseButton: true,
//     isOverlayTapDismiss: true,

//     descStyle: TextStyle(fontWeight: FontWeight.bold),
//     // descTextAlign: TextAlign.start,
//     alertPadding: EdgeInsets.all(10),
//     buttonAreaPadding: EdgeInsets.all(10),
//     animationDuration: Duration(milliseconds: 200),

//     alertBorder: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20.0),
//       side: BorderSide(
//         color: Colors.grey,
//       ),
//     ),

//     alertAlignment: Alignment.center,
//   );

//   Alert(
//       style: alertStyle,
//       context: contex2,
//       image: Icon(
//         Icons.gps_off,
//         color: Get.theme.primaryColorDark,
//         size: 70,
//       ),
//       title:"",
//       buttons: [
//         DialogButton(
//           color: Theme.of(contex2).primaryColor,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           radius: BorderRadius.circular(20),
//           onPressed: () {
//             Geolocator.openLocationSettings();
//             Get.back();
//           },
//           child: InkWell(
//             // onTap: () {
//             //   // location = null;
//             //   Geolocator.openLocationSettings();
//             //   Get.back();
//             // },
//             child: Container(
//               height: 50,
//               width: MediaQuery.of(contex2).size.width - 200,
//               child: Center(
//                 child: Text(
//                   "enableGps",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ]).show();
// }
