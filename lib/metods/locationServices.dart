import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// Future<LocationData> getLocation() async {
//   Location location = new Location();

//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   LocationData _locationData;

//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return null;
//     }
//   }

//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return null;
//     }
//   }

//   _locationData = await location.getLocation();
//   return _locationData;
// }

Future<Position?> getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
  // ResourceController controller = Get.find();
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Geolocator.openLocationSettings();
    print('Location services are disabled.');
    // return null;
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    // return Future.error(
    //     'Location permissions are permantly denied, we cannot request permissions.');
    Geolocator.openAppSettings();
    return null;
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      // return Future.error(
      //     'Location permissions are denied (actual value: $permission).');
      return null;
    }
  }
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Location " + position.latitude.toString());
    print("Location " + position.longitude.toString());
    // if (position != null) {
    //   print("is fake gps ................ .. . .. . . . . . . .");

    //   print("  ........... .. .. .. . .. .. . .     " +
    //       position.isMocked.toString());
    //   controller.isFakeGps.value = position.isMocked;
    //   // if (position.isMocked) {
    //   //   FakeGpsPopUp();
    //   // }
    // }
    return position;
  } on TimeoutException catch (_) {
    Get.snackbar(_.toString(), _.toString(),
        duration: Duration(seconds: 5),
        icon: Icon(
          Icons.info,
          color: Colors.white,
        ),
        colorText: Colors.white,
        backgroundColor: Get.theme.primaryColorDark.withOpacity(0.3));
    // LocationNotAvailable();
    return null;
  } catch (_) {
    print(_.toString());
    return null;
  }
}
