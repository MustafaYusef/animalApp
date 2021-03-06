import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/authController/loginController.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/controller/mainController/orderController.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/metods/state.dart';

import '../../constant.dart';

class MakeOrderScreen extends StatelessWidget {
  MakeOrderScreen({Key? key}) : super(key: key);
  OrderController _loginController = Get.put(OrderController());
  ItemDetailsController cartController = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            "أتمام عملية الشراء",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ).addDirectionality(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.grey[50],
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "تكلفة الطلب",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff3A3A3A),
                              fontWeight: FontWeight.bold),
                        ).addDirectionality(),
                        Text(
                          cartController.sumCart.value.toString() + " د.ع ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff3A3A3A),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "سعر التوصيل",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff3A3A3A),
                              fontWeight: FontWeight.bold),
                        ).addDirectionality(),
                        Text(
                          // _loginController.shippingPrice.value.data
                          //         .getShippingPrice[0].amount
                          _loginController.selectedShipPrice.value == 0
                              ? "حسب المحافظة"
                              : _loginController.selectedShipPrice.value
                                      .toString() +
                                  " د.ع ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff3A3A3A),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "المجموع",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff3A3A3A),
                              fontWeight: FontWeight.bold),
                        ).addDirectionality(),
                        Text(
                          ((cartController.sumCart.value +
                                          _loginController
                                              .selectedShipPrice.value) -
                                      _loginController.disscountAmount.value)
                                  .toString() +
                              " د.ع ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff3A3A3A),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ).addDirectionality(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/cat_image.png",
                        width: 150,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey[300]!),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 20,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        // padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            "الأسم الكامل",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ).addDirectionality(),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      controller:
                                          _loginController.nameTextController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey[100],
                                          filled: true,
                                          hintText: "الأسم الكامل",
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                          contentPadding: EdgeInsets.all(10)),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      validator: (value) =>
                                          value!.trim().isEmpty
                                              ? "يجب عليك ادخال الأسم الكامل"
                                              : null,
                                    ).addDirectionality(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            "المحافظة",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ).addDirectionality(),
                                        ),
                                      ],
                                    ),
                                    Obx(
                                      () => Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            border: Border.all(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: DropdownButton(
                                            underline: Container(),
                                            dropdownColor: Colors.white,
                                            hint: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                child: Text(
                                                  "المحافظة",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ).addDirectionality()),
                                            isExpanded: true,
                                            icon: Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              size: 24,
                                            ),
                                            value: _loginController
                                                .selectedProv.value,
                                            items: States.js.map((e) {
                                              return DropdownMenuItem(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        e.keys.elementAt(0),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                value: e,
                                              );
                                            }).toList(),
                                            onChanged: (dynamic value) {
                                              _loginController
                                                      .selectedProv.value =
                                                  value as Map<String,
                                                      List<String>>;
                                              print(_loginController
                                                  .selectedProv
                                                  .value
                                                  .values
                                                  .first);
                                              if (_loginController
                                                      .selectedProv.value.keys
                                                      .toString() ==
                                                  "(بغداد)") {
                                                _loginController
                                                        .selectedShipPrice
                                                        .value =
                                                    _loginController
                                                        .shippingPrice
                                                        .value
                                                        .data!
                                                        .getShippingPrice![0]
                                                        .amount!;
                                              } else {
                                                _loginController
                                                        .selectedShipPrice
                                                        .value =
                                                    _loginController
                                                        .shippingPrice
                                                        .value
                                                        .data!
                                                        .getShippingPrice![1]
                                                        .amount!;
                                              }
                                              _loginController
                                                  .selectedcity.value = "";
                                            }),
                                      ).addDirectionality(),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            "المدينة",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ).addDirectionality(),
                                        ),
                                      ],
                                    ),
                                    // try {

                                    // } catch (e) {
                                    // }
                                    Obx(
                                      () => Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            border: Border.all(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: _loginController
                                                    .selectedProv.value ==
                                                null
                                            ? Container()
                                            : DropdownButton(
                                                underline: Container(),
                                                dropdownColor: Colors.white,
                                                hint: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Text(
                                                      "المدينة",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ).addDirectionality()),
                                                isExpanded: true,
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  size: 24,
                                                ),
                                                value:
                                                    _loginController
                                                                .selectedcity
                                                                .value ==
                                                            ""
                                                        ? null
                                                        : _loginController
                                                            .selectedcity.value,
                                                items: _loginController
                                                    .selectedProv
                                                    .value
                                                    .values
                                                    .first
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            e,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                    value: e,
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  _loginController.selectedcity
                                                      .value = value.toString();
                                                  // print(_loginController
                                                  //     .selectedcity.value);
                                                }),
                                      ).addDirectionality(),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            "العنوان",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ).addDirectionality(),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      controller:
                                          _loginController.addressController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey[100],
                                          filled: true,
                                          hintText: "العنوان الكامل",
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                          contentPadding: EdgeInsets.all(10)),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      validator: (value) =>
                                          value!.trim().isEmpty
                                              ? "يجب عليك ادخال العنوان الكامل"
                                              : null,
                                    ).addDirectionality(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            "رقم الهاتف",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ).addDirectionality(),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      controller:
                                          _loginController.phoneController,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 11,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9,٠-٩]')),
                                      ],
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey[100],
                                          filled: true,
                                          hintText: "رقم الهاتف",
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                          contentPadding: EdgeInsets.all(10)),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      validator: (value) =>
                                          value!.trim().isEmpty
                                              ? "يجب عليك ادخال رقم الهاتف"
                                              : null,
                                    ).addDirectionality(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            "ملاحظات",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ).addDirectionality(),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      controller:
                                          _loginController.noteController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey[100],
                                          filled: true,
                                          hintText: "ملاحظات",
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                          contentPadding: EdgeInsets.all(10)),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      // validator: (value) =>
                                      //     value.trim().isEmpty
                                      //         ? "يجب عليك ادخال أسم الحيوان"
                                      //         : null,
                                    ).addDirectionality(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Container(
                                  height: 60.0,
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Get.theme.accentColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                              bottomRight:
                                                  Radius.circular(30))),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (_loginController
                                                .phoneController!.text
                                                .toString()
                                                .length ==
                                            11) {
                                          _loginController.makeOrder();
                                        } else {
                                          // Toast.show(validEmail(), Get.context,
                                          //     duration: Toast.LENGTH_LONG,
                                          //     gravity: Toast.BOTTOM);
                                          Get.snackbar("ادخل رقم هاتف صحيح",
                                              "ادخل رقم هاتف صحيح",
                                              duration: Duration(seconds: 3),
                                              icon: Icon(
                                                Icons.info,
                                                color: Colors.white,
                                              ),
                                              colorText: Colors.white,
                                              backgroundColor: Get
                                                  .theme.primaryColorDark
                                                  .withOpacity(0.3));
                                        }
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Text(
                                            "أرسال",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ).addDirectionality(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
              )),
            ),
          ],
        ));
  }
}
