import 'package:animal_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "عيادة الكرخ البيطرية",
        description: "طب وجراحة الحيوانات المنزلية الأليفة",
        pathImage: "assets/images/slider1.png",
        backgroundColor: Get.theme.primaryColor,
      ),
    );
    slides.add(
      new Slide(
        title: "عيادة الكرخ البيطرية",
        description: "مستلزمات بيطرية وأعلاف لجميع أنواع الحيوانات",
        pathImage: "assets/images/slider2.png",
        backgroundColor: Get.theme.primaryColor,
      ),
    );
    slides.add(
      new Slide(
        title: "عيادة الكرخ البيطرية",
        description: "خدمة تلقيح لجميع أنواع الحيوانات",
        pathImage: "assets/images/slider3.png",
        backgroundColor: Get.theme.primaryColor,
      ),
    );
  }

  void onDonePress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("intro", true);
    Get.offAll(Main(0));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      nameSkipBtn: "تخطي",
      nameDoneBtn: "تم",
      nameNextBtn: "التالي",
      slides: this.slides,
      colorDot: Colors.white,
      colorActiveDot: Get.theme.accentColor,
      onDonePress: this.onDonePress,
    );
  }
}
