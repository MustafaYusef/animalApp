import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';

import 'package:animal_app/metods/methods.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  // LoginController _profController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          elevation: 0,
          title: Text("تواصل معنا",
                  style: TextStyle(color: Colors.white, fontSize: 22))
              .addDirectionality(),
          centerTitle: true,
        ),
        body: Container(
            child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  if (Platform.isIOS) {
                    try {
                      await launch(
                        "https://www.facebook.com/Tebafashionn/",
                        forceSafariVC: false,
                      );
                    } catch (_) {
                      print(_.toString());
                    }
                  } else if (Platform.isAndroid) {
                    print("click");
                    try {
                      await launch(
                        "https://www.facebook.com/Tebafashionn/",
                        forceSafariVC: false,
                      );
                    } catch (_) {
                      print(_.toString());
                    }
                  }
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "تواصل معنا على صفحتنا",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/facebook.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  print("clickkkkkk");

                  if (Platform.isIOS) {
                    try {
                      await launch(
                        getUrl(),
                        forceSafariVC: false,
                      );
                    } catch (_) {
                      print(_.toString());
                    }
                  } else if (Platform.isAndroid) {
                    print("click");
                    try {
                      await launch(
                        getUrl(),
                        forceSafariVC: false,
                      );
                    } catch (_) {
                      print(_.toString());
                    }
                  }
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "اتصل بنا",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/whatsapp.png",
                          width: 50,
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

String getUrl() {
  String message = "";
  // Uri.parse(message);

  if (Platform.isAndroid) {
    // add the [https]
    return "https://wa.me/+9647733333965/?text=${Uri.parse(message)}"; // new line
  } else {
    // add the [https]
    return "https://api.whatsapp.com/send?phone=+9647733333965=${Uri.parse(message)}"; // new line
  }
}
