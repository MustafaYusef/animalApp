import 'package:flutter/material.dart';
import 'package:animal_app/data/myOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/orderController.dart';
import 'package:animal_app/metods/cancelOrderPopUp.dart';
import 'package:animal_app/metods/methods.dart';
import 'package:animal_app/ui/customWidget/noNetWidget.dart';
import 'package:animal_app/ui/customWidget/orderItemCard.dart';
import 'package:animal_app/ui/screens/orderDetails.dart';

class OrderDetailsScreen extends StatelessWidget {
  final MyOrder order;
  OrderDetailsScreen(this.order);
  OrderController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "تفاصيل الطلب",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ).addDirectionality(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height - 100,
              child: Column(
                children: [
                  Container(
                    height: 240,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
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
                                        "رقم الطلب  : ",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        order.name,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ).addDirectionality(),
                                      Text(
                                        "الأسم  : ",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        order.phone,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                      Text(
                                        "رقم الهاتف : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        order.price.toString() + " " + "د.ع",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                      Text(
                                        "سعر الطلب : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        order.shpping_price.toString() +
                                            " " +
                                            "د.ع",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                      Text(
                                        "سعر التوصيل : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: order.status != 0
                                            ? Container()
                                            : Container(
                                                width: 100,
                                                height: 40.0,
                                                child: RaisedButton(
                                                  color: Colors.red[400]
                                                      .withOpacity(0.9),
                                                  onPressed: () {
                                                    CancelOrderPopUp(
                                                        context, order.id);
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  padding: EdgeInsets.all(0.0),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "ألغاء الطلب",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ).addDirectionality(),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        order.createdAt
                                            .toString()
                                            .split("T")[0]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                      Text(
                                        "تاريخ الطلب : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        getStatus(order.status),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                      Text(
                                        "حالة الطلب : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ).addDirectionality(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: ListView.builder(
                        itemCount: order.orderItems.length,
                        primary: false,
                        itemBuilder: (context, index) {
                          return orderItemCard(order.orderItems[index]);
                        }),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
