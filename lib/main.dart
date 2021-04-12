import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:animal_app/ui/screens/favouriteScreen.dart';
import 'package:animal_app/ui/screens/mainScreen.dart';
import 'package:animal_app/ui/screens/profile/profileScreen.dart';
import 'package:animal_app/ui/screens/sectionsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/mainController/itemDetailsController.dart';

void main() => runApp(
      baseWedget(),
    );

class baseWedget extends StatefulWidget {
  const baseWedget({Key key}) : super(key: key);

  @override
  _baseWedgetState createState() => _baseWedgetState();
}

class _baseWedgetState extends State<baseWedget> {
  @override
  void initState() {
    getToken();

    super.initState();
  }

  bool flage = false;
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = await prefs.get('token');
    flage = token == "" || token == null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init("678edd4c-48a6-435a-8bd3-c0823ce40f8d", iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission

    return GetMaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xff2980B9),
            accentColor: Color(0xffC0392B),
            primaryColorLight: Color(0xffFEE8C1),
            primaryColorDark: Color(0xff262628),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Color(0xffC0392B)))),
        darkTheme: ThemeData(
            primaryColor: Color(0xff2980B9),
            accentColor: Color(0xffC0392B),
            primaryColorLight: Color(0xffFEE8C1),
            primaryColorDark: Color(0xff262628),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Color(0xffC0392B)))),
        debugShowCheckedModeBanner: false,
        home: Main(0));
  }
}

class Main extends StatefulWidget {
  int indexB = 0;
  Main([this.indexB]);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ItemDetailsController controller = Get.put(ItemDetailsController());

  @override
  void initState() {
    _child = MainScreen();
    super.initState();
  }

  bool isOpened = false;

  MainScreen _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          )),
      body: selectedWidget(widget.indexB),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: widget.indexB == 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey),
                title: Container()),

            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border,
                    color: widget.indexB == 1
                        ? Theme.of(context).primaryColor
                        : Colors.grey),
                title: Container()),
            BottomNavigationBarItem(
                icon: Icon(Icons.list,
                    color: widget.indexB == 2
                        ? Theme.of(context).primaryColor
                        : Colors.grey),
                title: Container()),

            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,
                    color: widget.indexB == 3
                        ? Theme.of(context).primaryColor
                        : Colors.grey),
                title: Container())

            // Icon(Icons.more_horiz,
            //     size: 30, color: indexB == 4 ? Colors.white : Colors.grey),
          ],
          onTap: (index) {
            //Handle button tap
            print(index);
            setState(() {
              widget.indexB = index;
            });
          },
        ),
      ),
    );
  }

  Widget selectedWidget(int index) {
    if (index == 0) {
      return _child;
    } else if (index == 1) {
      return FavouriteScreen();
    } else if (index == 2) {
      return SectionsScreen();
    } else if (index == 3) {
      return ProfileScreen();
    }
  }
}
