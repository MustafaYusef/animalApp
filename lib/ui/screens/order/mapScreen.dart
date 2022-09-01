import 'dart:async';
import 'package:animal_app/controller/mainController/orderController.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../metods/locationEnablePop.dart';
import '../../../metods/locationServices.dart';

class MapScreen extends StatefulWidget {
  // final int id;
  // final List<String> itemsId;
  // final List<String> counts;
  // final List<String> newcounts;
  // final int sum;
  int numCall = 0;
  // MapScreen();

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  OrderController controller1 = Get.find();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  initState() {
    super.initState();
    moveCamera();
  }

  double lat = 0;
  double lon = 0;
  List<Marker> markers = [];
  moveCamera() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // Position? location;
    if (!serviceEnabled) {
      // location = null;
      Get.back();
      EnableGpsPop(Get.context);
    } else {
      controller1.location = (await getLocation())!;
      controller1.isLocSelected.value = true;
    }
    lat = controller1.location!.latitude;
    lon = controller1.location!.longitude;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(
            controller1.location!.latitude, controller1.location!.longitude),
        // tilt: 59.440717697143555,
        zoom: 16.151926040649414)));
    setState(() {
      markers.add(Marker(
          markerId: MarkerId("1"),
          draggable: true,
          infoWindow: InfoWindow(title: "موقعك الحالي"),
          onDragEnd: ((value) {
            lat = value.latitude;
            lon = value.longitude;
            controller1.location !=
                Position(
                    longitude: lon,
                    latitude: lat,
                    timestamp: controller1.location!.timestamp,
                    accuracy: controller1.location!.accuracy,
                    altitude: controller1.location!.altitude,
                    heading: controller1.location!.heading,
                    speed: controller1.location!.speed,
                    speedAccuracy: controller1.location!.speedAccuracy);
          }),
          position: LatLng(lat, lon)));
    });
    // getNum();
    if (widget.numCall != 1) {
      showAlertDragPin(context);
    }
  }

  int notifNum = 0;
  int cartNum = 0;

  // getNum() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     notifNum = prefs.getInt('notification');
  //     cartNum = prefs.getInt('cart');
  //   });
  // }

  bool mapType = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // endDrawer: drawar(index: 0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "تحديد الموقع",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(children: <Widget>[
          GoogleMap(
            rotateGesturesEnabled: true,
            markers: Set.from(markers),
            mapType: mapType ? MapType.normal : MapType.satellite,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                      onPressed: moveCamera,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      child: Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (mapType) {
                            mapType = false;
                          } else {
                            mapType = true;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 5,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text("تم",
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)),
                      ),
                      onPressed: () {
                        Get.back();
                      }),
                ),
              )
              // : Theme(
              //     child: CircularProgressIndicator(),
              //     data: new ThemeData(
              //       primaryColor: Colors.blueAccent,
              //       primaryColorDark: Colors.red,
              //     ),
              //   ),
              )
        ]),
      ),
    );
  }
//  showAlertDialog(BuildContext context) {
//     // set up the buttons

//     Widget continueButton = Container(
//                     margin: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     width: 100,
//                     height: 50,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: RaisedButton(
//                           color:Theme.of(context).primaryColor,
//                           elevation: 5,
//                           child: Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Text("تم",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 20)),
//                           ),
//                           onPressed: () async {
//                            Navigator.of(context).pop();
//                            Navigator.pushReplacement(context,
//                                 MaterialPageRoute(builder: (_) {
//                               return OrderScreen();
//                             }));
//                           }),
//                     ),
//                   );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(

//       title: Directionality(textDirection: TextDirection.rtl,
//         child: Text("شكرا ألك لأنك طلبت من عدنا ")),
//       content: Directionality(
//         textDirection: TextDirection.rtl,
//               child: Text(
//             "راح نتصل بيك قريبا",style: TextStyle(color: Color(0xffFFB300),
//             fontWeight: FontWeight.bold,fontSize: 18),),
//       ),
//       actions: [

//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

  // showAlert(BuildContext context) {
  //   var alertStyle = AlertStyle(
  //     animationType: AnimationType.fromBottom,
  //     isCloseButton: false,
  //     isOverlayTapDismiss: false,
  //     descStyle: TextStyle(fontWeight: FontWeight.bold),
  //     animationDuration: Duration(milliseconds: 400),
  //     alertBorder: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //       side: BorderSide(
  //         color: Colors.grey,
  //       ),
  //     ),
  //     titleStyle: TextStyle(
  //       color: Color(0xffFFB300),
  //     ),
  //   );
  //   Alert(
  //     context: context,
  //     type: AlertType.info,
  //     title: "شكرا ألك لأنك طلبت من عدنا ",
  //     desc: "راح نتصل بيك قريبا",
  //     style: alertStyle,
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "تم",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
  //             return OrderScreen();
  //           }));
  //         },
  //         color: Theme.of(context).primaryColor,
  //       ),
  //       // DialogButton(
  //       //   child: Text(
  //       //     "GRADIENT",
  //       //     style: TextStyle(color: Colors.white, fontSize: 20),
  //       //   ),
  //       //   onPressed: () => Navigator.pop(context),
  //       //   gradient: LinearGradient(colors: [
  //       //     Color.fromRGBO(116, 116, 191, 1.0),
  //       //     Color.fromRGBO(52, 138, 199, 1.0)
  //       //   ]),
  //       // )
  //     ],
  //   ).show();
  // }

  showAlertDragPin(BuildContext context) {
    widget.numCall = 1;
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color(0xffFFB300),
      ),
    );
    Alert(
      context: context,
      type: AlertType.info,
      title: "تغيير الموقع",
      desc: "اضغط مطولاً على الدبوس لتغيير موقعك",
      style: alertStyle,
      buttons: [
        DialogButton(
          child: Text(
            "تم",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
        ),
        // DialogButton(
        //   child: Text(
        //     "GRADIENT",
        //     style: TextStyle(color: Colors.white, fontSize: 20),
        //   ),
        //   onPressed: () => Navigator.pop(context),
        //   gradient: LinearGradient(colors: [
        //     Color.fromRGBO(116, 116, 191, 1.0),
        //     Color.fromRGBO(52, 138, 199, 1.0)
        //   ]),
        // )
      ],
    ).show();
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraUpdate.newCameraPosition( CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(loc.latitude,loc.longitude),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414))));
  // }
  // Future<UserLocation> getLocation() async {
  //   Location location = new Location();
  //   var _locationData = UserLocation();
  //   var locationServeces = LocationServices();

  //   await location.requestPermission().then((granted) async {
  //     if (granted != null) {
  //       var loc = await locationServeces.getCurrentLocation();
  //       if (loc != null) {
  //         _locationData = loc;
  //       }
  //     }
  //   });

  //   print("location     :" + _locationData.lat.toString());
  //   return _locationData;
  // }
}
