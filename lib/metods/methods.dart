import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

List<String> convertToString(String s) {
  List<String> list =
      s.substring(1, s.length - 1).split(",").map((e) => e).toList();
  return list;
}

List<int> convertToInt(String s) {
  List<int> list =
      s.substring(1, s.length - 1).split(",").map((e) => int.parse(e)).toList();
  return list;
}

// String replaceArabicNumber(String input) {

// }
extension replaceArabicNumber on String {
  String changeToEngilish() {
    String output = "";
    const numberMap = {
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
      '٠': '0'
    };
    for (int i = 0; i < this.length; i++) {
      if (numberMap.containsKey(this[i])) {
        output += numberMap[this[i]];
      }
    }
    if (output == "") {
      return this;
    } else {
      return output;
    }
  }
}

String getStatus(int status) {
  if (status == 0) {
    return "في الأنتظار";
  } else if (status == 1) {
    return "تم القبول";
  } else if (status == 2) {
    return "تم الألغاء";
  } else if (status == 3) {
    return "تم التجهيز";
  }
}

extension AddDirectionality on Widget {
  addDirectionality() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: this,
    );
  }
}

Color getColorFromColorCode(String code) {
  return code.length < 7
      ? Colors.white
      : Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Future<String> getuserId() async {
  var status = await OneSignal.shared.getPermissionSubscriptionState();
  var playerId = status.subscriptionStatus.userId;
  print("plyer id  " + playerId.toString());
  return playerId;
}
