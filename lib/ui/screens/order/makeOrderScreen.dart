import 'package:animal_app/data/cityModel.dart';
import 'package:animal_app/ui/screens/order/mapScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:animal_app/controller/mainController/itemDetailsController.dart';
import 'package:animal_app/controller/mainController/orderController.dart';
import 'package:animal_app/metods/extentions.dart';

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
                                            value: _loginController.selectedProv
                                                        .value.id ==
                                                    null
                                                ? null
                                                : _loginController
                                                    .selectedProv.value,
                                            items: _loginController.goverment
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
                                                        e.name!,
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
                                                  .selectedProv.value = value;
                                              _loginController.getCity();

                                              //     value as Map<String,
                                              //         List<String>>;
                                              // print(_loginController
                                              //     .selectedProv
                                              //     .value
                                              //     .values
                                              //     .first);
                                              // if (_loginController
                                              //         .selectedProv.value.keys
                                              //         .toString() ==
                                              //     "(بغداد)") {
                                              //   _loginController
                                              //           .selectedShipPrice
                                              //           .value =
                                              //       _loginController
                                              //           .shippingPrice
                                              //           .value
                                              //           .data!
                                              //           .getShippingPrice![0]
                                              //           .amount!;
                                              // } else {
                                              //   _loginController
                                              //           .selectedShipPrice
                                              //           .value =
                                              //       _loginController
                                              //           .shippingPrice
                                              //           .value
                                              //           .data!
                                              //           .getShippingPrice![1]
                                              //           .amount!;
                                              // }
                                              _loginController
                                                      .selectedcity.value =
                                                  City(
                                                      id: null,
                                                      name: "",
                                                      shippingPrice: null,
                                                      fastShipping: null,
                                                      fastPrice: null);
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
                                                    .selectedProv.value.id ==
                                                null
                                            ? Container()
                                            : Container(
                                                child: _loginController
                                                        .cities.isEmpty
                                                    ? Container(
                                                        height: 50,
                                                        child: TextFormField(
                                                          // controller:
                                                          //     _loginController
                                                          //         .noteController,
                                                          onChanged: (text) {
                                                            _loginController
                                                                    .selectedcity
                                                                    .value
                                                                    .name =
                                                                text.toString();
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          100],
                                                                  filled: true,
                                                                  hintText:
                                                                      "المدينة",
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 0,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                      width: 0,
                                                                    ),
                                                                  ),
                                                                  // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10)),
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          // validator: (value) =>
                                                          //     value!
                                                          //             .trim()
                                                          //             .isEmpty
                                                          //         ? "يجب عليك ادخال أسم المدينة"
                                                          //         : null,
                                                        ).addDirectionality(),
                                                      )
                                                    : DropdownButton(
                                                        underline: Container(),
                                                        dropdownColor: Colors
                                                            .white,
                                                        hint: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                            child: Text(
                                                              "المدينة",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            )
                                                                .addDirectionality()),
                                                        isExpanded: true,
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_outlined,
                                                          size: 24,
                                                        ),
                                                        value: _loginController
                                                                    .selectedcity
                                                                    .value
                                                                    .id ==
                                                                null
                                                            ? null
                                                            : _loginController
                                                                .selectedcity
                                                                .value,
                                                        items: _loginController
                                                            .cities
                                                            .map((e) {
                                                          return DropdownMenuItem(
                                                            child: Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    e.name!,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black,
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
                                                        onChanged:
                                                            (dynamic value) {
                                                          _loginController
                                                                  .selectedcity
                                                                  .value =
                                                              value as City;
                                                          _loginController
                                                                  .selectedShipPrice
                                                                  .value =
                                                              _loginController
                                                                  .selectedcity
                                                                  .value
                                                                  .shippingPrice!;
                                                          _loginController
                                                                  .isFastAvailable
                                                                  .value =
                                                              _loginController
                                                                  .selectedcity
                                                                  .value
                                                                  .fastShipping!;

                                                          if (_loginController
                                                                  .notFast
                                                                  .value ==
                                                              0) {
                                                            _loginController
                                                                .notFast
                                                                .value = 1;
                                                            _loginController
                                                                .fast.value = 0;
                                                            _loginController
                                                                    .selectedShipPrice
                                                                    .value =
                                                                _loginController
                                                                    .selectedcity
                                                                    .value
                                                                    .shippingPrice!;
                                                          }
                                                          // print(_loginController
                                                          //     .selectedcity.value);
                                                        }),
                                              ),
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
                                      // validator: (value) =>
                                      //     value!.trim().isEmpty
                                      //         ? "يجب عليك ادخال العنوان الكامل"
                                      //         : null,
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
                                      // maxLength: 11,
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
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Obx(
                                      () => !_loginController
                                              .isLocSelected.value
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 50.0,
                                                  width: 200,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Get.theme.accentColor,
                                                      // shape: RoundedRectangleBorder(
                                                      //     borderRadius:
                                                      //         BorderRadius.c
                                                      //                     ),
                                                    ),
                                                    onPressed: () {
                                                      Get.to(MapScreen());
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.pin_drop,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 25,
                                                          ),
                                                          Text(
                                                            "تحديد الموقع",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ).addDirectionality(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Card(
                                              semanticContainer: true,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    padding: EdgeInsets.all(10),
                                                    child: Image.asset(
                                                      "assets/images/map.png",
                                                      width: 70,
                                                      height: 80,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: Get.width / 2.5,
                                                      height: 100,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            height: 40.0,
                                                            width: 100,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: Colors
                                                                    .white,
                                                                shape: RoundedRectangleBorder(
                                                                    side: BorderSide(
                                                                        color: Get
                                                                            .theme
                                                                            .accentColor,
                                                                        width:
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                              ),
                                                              onPressed: () {
                                                                Get.to(
                                                                    MapScreen());
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "تغيير",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Get
                                                                        .theme
                                                                        .accentColor,
                                                                  ),
                                                                ).addDirectionality(),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ).addDirectionality(),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              color: Colors.white,
                                              elevation: 5,
                                              margin: EdgeInsets.all(4),
                                            ),
                                    ),
                                    Obx(
                                      () => _loginController
                                              .isFastAvailable.value
                                          ? Container(
                                              width: Get.width,
                                              height: 120,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Obx(
                                                () => Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "توصيل سريع",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors
                                                                .grey[800],
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        Radio(
                                                            toggleable: true,
                                                            // value: 2,
                                                            //

                                                            value:
                                                                _loginController
                                                                    .fast.value,
                                                            groupValue: 1,
                                                            activeColor: Get
                                                                .theme
                                                                .primaryColor,
                                                            onChanged: (val) {
                                                              if (_loginController
                                                                      .fast
                                                                      .value ==
                                                                  0) {
                                                                _loginController
                                                                    .fast
                                                                    .value = 1;
                                                                _loginController
                                                                    .notFast
                                                                    .value = 0;
                                                                _loginController
                                                                        .selectedShipPrice
                                                                        .value =
                                                                    _loginController
                                                                        .selectedcity
                                                                        .value
                                                                        .fastPrice!;
                                                              }

                                                              print(
                                                                  "_loginController.fast.value ..........");
                                                              print(
                                                                  _loginController
                                                                      .fast
                                                                      .value);
                                                              print(
                                                                  _loginController
                                                                      .notFast
                                                                      .value);
                                                            }),
                                                        // Row(
                                                        //   children: [
                                                        //     Text(
                                                        //       "يكون وقت التوصيل أقل من ٦٠ دقيقة",
                                                        //       style: TextStyle(
                                                        //         fontSize: 13,
                                                        //         color: Colors
                                                        //             .grey[800],
                                                        //         fontWeight:
                                                        //             FontWeight
                                                        //                 .normal,
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "توصيل عادي",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors
                                                                .grey[800],
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        // Radio(value: value, groupValue: groupValue, onChanged: onChanged)
                                                        Radio(
                                                            toggleable: true,
                                                            // value: 2,
                                                            // toggleable: true,
                                                            value:
                                                                _loginController
                                                                    .notFast
                                                                    .value,
                                                            groupValue: 1,
                                                            activeColor: Get
                                                                .theme
                                                                .primaryColor,
                                                            onChanged: (val) {
                                                              if (_loginController
                                                                      .notFast
                                                                      .value ==
                                                                  0) {
                                                                _loginController
                                                                    .notFast
                                                                    .value = 1;
                                                                _loginController
                                                                    .fast
                                                                    .value = 0;
                                                                _loginController
                                                                        .selectedShipPrice
                                                                        .value =
                                                                    _loginController
                                                                        .selectedcity
                                                                        .value
                                                                        .shippingPrice!;
                                                              }

                                                              print(
                                                                  "_loginController.notFast.value ..........");
                                                              print(
                                                                  _loginController
                                                                      .notFast
                                                                      .value);
                                                              print(
                                                                  _loginController
                                                                      .fast
                                                                      .value);
                                                              // print(controller.isEmpty.value);
                                                            }),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "يكون وقت التوصيل خلال ساعات",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .grey[800],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ).addDirectionality(),
                                              ),
                                            )
                                          : Container(),
                                    ),
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
                                                .selectedcity.value.name !=
                                            "") {
                                          _loginController.makeOrder();
                                        } else {
                                          Get.snackbar("ادخل اسم المدينة",
                                              "ادخل اسم المدينة",
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
