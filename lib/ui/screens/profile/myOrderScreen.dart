import 'package:animal_app/ui/customWidget/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/orderController.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/screens/profile/orderDetails.dart';

class MyOrderScreen extends StatefulWidget {
  MyOrderScreen({Key? key}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  OrderController controller = Get.put(OrderController());
  @override
  void initState() {
    controller.getOrder();
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
              controller.getOrder();
            }
          }
        }
      });
    Future<bool> _wiilPop() async {
      Get.delete<OrderController>();
      Get.back();
      return true;
    }

    return WillPopScope(
      onWillPop: _wiilPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "طلباتي",
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
                  () => controller.orders.isEmpty
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
                                        ? Text("لا يوجد طلبات لديك")
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
                                    controller.orders.clear();
                                    controller.lastPage.value = false;
                                    return controller.getOrder();
                                  },
                                  child: ListView(
                                      controller: _scrollController,
                                      children: controller.orders.map((e) {
                                        return orderCard(e);
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
Widget orderCard(MyOrder order) {
  return InkWell(
    onTap: () {
      Get.to(OrderDetailsScreen(order));
    },
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 35.0,
                width: 120,
                margin: EdgeInsets.only(left: 5),
                child: RaisedButton(
                  color: order.status == 0
                      ? Colors.grey[200]
                      : Get.theme.accentColor,
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
                      order.status == 0 ? "يتم التجهيز" : "تم التوصيل",
                      style: TextStyle(
                        fontSize: 16,
                        color: order.status == 0 ? Colors.black : Colors.white,
                      ),
                    ).addDirectionality(),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      order.id.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ).addDirectionality(),
                    Text(
                      "رقم الطلب : ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ).addDirectionality(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      order.price.toString(),
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ).addDirectionality(),
                    Text(
                      "سعر الطلب : ",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ).addDirectionality(),
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
      ),
    ),
  );
}
