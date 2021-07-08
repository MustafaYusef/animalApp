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

class KidsAge {
  int years;
  int months;
  int days;
  KidsAge({this.years = 0, this.months = 0, this.days = 0});
}

KidsAge calculateAge(DateTime? birthDate) {
  if (birthDate != '') {
    // var birthDate = DateTime.tryParse(birthday);
    if (birthDate != null) {
      final now = new DateTime.now();

      int years = now.year - birthDate.year;
      int months = now.month - birthDate.month;
      int days = now.day - birthDate.day;

      if (months < 0 || (months == 0 && days < 0)) {
        years--;
        months += (days < 0 ? 11 : 12);
      }

      if (days < 0) {
        final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
        days = now.difference(monthAgo).inDays + 1;
      }

      return KidsAge(years: years, months: months, days: days);
    } else {
      print('getTheKidsAge: not a valid date');
    }
  } else {
    print('getTheKidsAge: date is empty');
  }
  return KidsAge();
}

// Period calculateAge(DateTime? birthDate) {
//   DateTime currentDate = DateTime.now();
//   int age;
//   // int month1 = currentDate.month;
//   // int month2 = birthDate.month;
//   // if (month2 > month1) {
//   //   age--;
//   // } else if (month1 == month2) {
//   //   int day1 = currentDate.day;
//   //   int day2 = birthDate.day;
//   //   if (day2 > day1) {
//   //     age--;
//   //   }
//   // }
//   LocalDate a = LocalDate.today();
//   LocalDate b =
//       LocalDate.dateTime(DateTime.parse(birthDate.toString().split(" ")[0]));
//   print("aaaaaaa");
//   print(a);
//   print("bbbbbbbb");

//   print(b);
//   Period diff = a.periodSince(b);
//   // age = currentDate.difference(birthDate).inDays ~/ 30;
//   // if (age >= 12) {
//   //   return age / 12;
//   // } else {
//   //   return age;
//   // }
//   return diff;
// }

Future<String?> getId() async {
  String? playerId = "null";
  try {
    OneSignal.shared.getDeviceState().then((deviceState) {
      playerId = deviceState!.userId;
      print("OneSignal: device state: ${deviceState.jsonRepresentation()}");
    });
    // var status = await OneSignal.shared.getPermissionSubscriptionState();
    // playerId = status.subscriptionStatus.userId;
    print("plyer id  " + playerId.toString());
  } catch (_) {
    print("play servicesss   one signel");
    print(_.toString());
  }

  return playerId;
}

String getAge(KidsAge period) {
  String age;
  if (period.years >= 1) {
    age = period.years.toString() +
        " سنة " +
        (period.months >= 1 ? " و " + period.months.toString() + " شهر " : "");
  } else if (period.months >= 1) {
    age = period.months.toString() +
        " شهر " +
        (period.days >= 1 ? " و " + period.days.toString() + " يوم " : "");
  } else {
    age = period.days.toString() + " يوم ";
  }
  return age;
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
        output += numberMap[this[i]]!;
      } else {
        output += this[i];
      }
    }
    if (output == "") {
      return this;
    } else {
      return output;
    }
  }
}

String? getStatus(int status) {
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

// Future<String> getuserId() async {
//   var status = await OneSignal.shared.getPermissionSubscriptionState();
//   var playerId = status.subscriptionStatus.userId;
//   print("plyer id  " + playerId.toString());
//   return playerId;
// }
