import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

// Future<File> testCompressAndGetFile(File file, String targetPath) async {
//     var result = await FlutterImageCompress.compressAndGetFile(
//         file.absolute.path, targetPath,
//         quality: 88,
//         rotate: 180,
//       );

//     print(file.lengthSync());
//     print(result.lengthSync());

//     return result;
//   }
Future<Uint8List> compressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: 94,
    rotate: 0,
  );
  print(file.lengthSync());
  print(result?.length);
  return result!;
}

// Future<Uint8List> compressFile(File file) async {
//   var result = await (FlutterImageCompress.compressWithFile(
//     file.absolute.path,
//     // minHeight: 1920,
//     // minWidth: 1080,
//     quality: 94,
//     rotate: 0,
//   ) as FutureOr<Uint8List>);
//   print(file.lengthSync());
//   print(result.length);
//   return result;
// }
