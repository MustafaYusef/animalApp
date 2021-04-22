import 'package:animal_app/controller/servicesController.dart';
import 'package:animal_app/data/myBookingServices.dart';
import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/orderController.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/screens/profile/orderDetails.dart';

class MyBookingScreen extends StatefulWidget {
  MyBookingScreen({Key key}) : super(key: key);

  @override
  _MyBookingScreenState createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  ServicesController controller = Get.put(ServicesController());
  @override
  void initState() {
    controller.getMyBooking();
    super.initState();
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (!controller.isLoading.value) {
            if (!controller.lastPage.value) {
              controller.getMyBooking();
            }
          }
        }
      });
    return WillPopScope(
      onWillPop: () {
        // Get.delete<OrderController>();
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "الحجوزات",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            child: Container(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => controller.myBooking.isEmpty
                      ? Container(
                          child: Center(
                            child: controller.noNetFlage.value
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      NoInternetWidget(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        // onTap: () {
                                        //   controller.initial();
                                        // },
                                        child: Text(
                                          "إعادة المحاولة",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    child: controller.isEmptyFlage.value
                                        ? Text("لا يوجد حجوزات لديك")
                                        : Container(
                                            height: Get.height,
                                            width: Get.width,
                                            child: Center(
                                              child: Container(
                                                  child: circularProgress()),
                                            ),
                                          )),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: Container(
                                // padding: EdgeInsets.only(
                                //     bottom: controller.lastPage ? 0 : 20),
                                // child: ListView.builder(
                                //     itemCount: controller.orders.length,
                                //     itemBuilder: (context, index) {
                                //       return InkWell(
                                //         onTap: () {
                                //           Get.to(OrderDetailsScreen(
                                //               controller.orders[index]));
                                //         },
                                //         child:
                                //             orderCard(controller.orders[index]),
                                //       );
                                //     }),
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    controller.page.value = 1;
                                    controller.myBooking.clear();
                                    controller.lastPage.value = false;
                                    return controller.getMyBooking();
                                  },
                                  child: ListView(
                                      controller: _scrollController,
                                      children: controller.myBooking.map((e) {
                                        return bookingCard(e);
                                      }).toList()),
                                ),
                              ),
                            ),
                            !controller.isLoading.value
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 20,
                                          height: 20,
                                          color: Colors.transparent,
                                          margin: EdgeInsets.only(
                                              bottom: 20, top: 10),
                                          child: Theme(
                                            data: ThemeData(
                                                accentColor:
                                                    Get.theme.primaryColor,
                                                primaryColor:
                                                    Get.theme.primaryColor),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )),
                                    ],
                                  )
                          ],
                        ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

// Widget orderCard extends StatelessWidget {
//   orderCard(
//     this.order,
//   );

//   MyOrder order;

//   @override
Widget bookingCard(MyList order) {
  return InkWell(
    onTap: () {
      // Get.to(OrderDetailsScreen(order));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      child: Card(
        elevation: 3,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          order.pet == null
                              ? Text(
                                  "لا يوجد",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ).addDirectionality()
                              : Text(
                                  order.pet.name.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ).addDirectionality(),
                          Text(
                            "أسم الحيوان : ",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ).addDirectionality(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            order.services.inHouse == 1
                                ? "داخل المنزل"
                                : "داخل العيادة",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ).addDirectionality(),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "assets/images/icon_cat.png",
                            width: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(40)),
                      width: 70,
                      height: 70,
                      child: Image.asset("assets/images/dog_image.png"))
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      height: 35.0,
                      width: 140,
                      // margin: EdgeInsets.only(left: 5),
                      child: RaisedButton(
                        color: order.status == 0
                            ? Get.theme.accentColor
                            : Get.theme.primaryColor,
                        onPressed: () {
                          // controller.addCart(controller.id);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            order.status == 0
                                ? "لم يتم تحديد موعد"
                                : order.visitAt,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ).addDirectionality(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
