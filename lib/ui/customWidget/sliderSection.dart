import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/constant.dart';
import 'package:animal_app/data/bannersModel.dart';

import 'loadingImage.dart';

class sliderSection extends StatefulWidget {
  sliderSection({
    Key? key,
    required int current,
    required this.banners,
  })  : _current = current,
        super(key: key);

  int _current;
  List<BannerItem> banners;
  @override
  _sliderSectionState createState() => _sliderSectionState();
}

class _sliderSectionState extends State<sliderSection> {
  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      widget._current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        CarouselSlider.builder(
            itemCount: widget.banners.length == 0 ? 1 : widget.banners.length,
            options: CarouselOptions(
              height: Get.height / 3.5,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              aspectRatio: 2.0,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: onPageChange,
            ),
            itemBuilder: (BuildContext context, int itemIndex, int u) =>
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: Get.height / 3.5,
                                  width: MediaQuery.of(context).size.width,
                                  imageUrl: imageUrl +
                                      widget.banners[widget._current].photo!,
                                  placeholder: (context, url) => loadinImage(),
                                  errorWidget: (context, url, error) =>
                                      loadinImage()),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                        ),
                      )),
                )),
        Positioned(
            bottom: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.banners.map((image) {
                  return Container(
                    width: 12.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget._current == widget.banners.indexOf(image)
                            ? Colors.deepOrange
                            : Colors.white),
                  );
                }).toList(),
              ),
            )),
      ]),
    );
  }
}
