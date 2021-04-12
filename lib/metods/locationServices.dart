// import 'package:geolocator/geolocator.dart';

// // Future<LocationData> getLocation() async {
// //   Location location = new Location();

// //   bool _serviceEnabled;
// //   PermissionStatus _permissionGranted;
// //   LocationData _locationData;

// //   _serviceEnabled = await location.serviceEnabled();
// //   if (!_serviceEnabled) {
// //     _serviceEnabled = await location.requestService();
// //     if (!_serviceEnabled) {
// //       return null;
// //     }
// //   }

// //   _permissionGranted = await location.hasPermission();
// //   if (_permissionGranted == PermissionStatus.denied) {
// //     _permissionGranted = await location.requestPermission();
// //     if (_permissionGranted != PermissionStatus.granted) {
// //       return null;
// //     }
// //   }

// //   _locationData = await location.getLocation();
// //   return _locationData;
// // }

// Future<Position> getLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     Geolocator.openLocationSettings();
//     print('Location services are disabled.');
//     // return null;
//     return null;
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.deniedForever) {
//     // return Future.error(
//     //     'Location permissions are permantly denied, we cannot request permissions.');
//     Geolocator.openAppSettings();
//     return null;
//   }

//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission != LocationPermission.whileInUse &&
//         permission != LocationPermission.always) {
//       // return Future.error(
//       //     'Location permissions are denied (actual value: $permission).');
//       return null;
//     }
//   }
//   try {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//     return position;
//   } catch (_) {
//     print(_.toString());
//     return null;
//   }
// }
