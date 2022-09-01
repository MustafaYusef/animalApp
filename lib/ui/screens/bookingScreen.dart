import 'package:animal_app/controller/servicesController.dart';
import 'package:animal_app/data/myPetsModel.dart';
import 'package:animal_app/data/servicesModel.dart';
import 'package:animal_app/ui/screens/pets/addPetScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/metods/state.dart';

import '../../constant.dart';

class BookingScreen extends StatelessWidget {
  Service? item;
  BookingScreen(this.item);

  // ItemDetailsController cartController = Get.find();
  ServicesController _loginController = Get.find();
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
            "أتمام عملية الحجز",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ).addDirectionality(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/cat_image.png",
                    width: 200,
                    height: 150,
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
                          offset: Offset(0, 3), // changes position of shadow
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
                                        "أسم الحيوان",
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
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              "أسم الحيوان",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ).addDirectionality()),
                                        isExpanded: true,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 24,
                                        ),
                                        value: _loginController
                                                    .selectedPet.value.id ==
                                                null
                                            ? null
                                            : _loginController
                                                .selectedPet.value,
                                        items: _loginController.myPets.map((e) {
                                          return DropdownMenuItem(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    e.name!,
                                                    style: _loginController
                                                                .myPets
                                                                .indexOf(e) ==
                                                            _loginController
                                                                    .myPets
                                                                    .length -
                                                                1
                                                        ? TextStyle(
                                                            fontSize: 18,
                                                            color: Get.theme
                                                                .accentColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )
                                                        : TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
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
                                        onChanged: (dynamic value) {
                                          if (_loginController.myPets
                                                  .indexOf(value) ==
                                              _loginController.myPets.length -
                                                  1) {
                                            // Get.delete<
                                            //     ServicesController>();
                                            Get.to(AddPetsScreen());
                                          } else {
                                            _loginController.selectedPet.value =
                                                value as MyPet;
                                          }
                                        }),
                                  ).addDirectionality(),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                                // ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.end,
                                //   children: [
                                //     Container(
                                //       margin: EdgeInsets.symmetric(
                                //           horizontal: 10, vertical: 10),
                                //       child: Text(
                                //         "نوع الحيوان",
                                //         style: TextStyle(
                                //           fontSize: 18,
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.normal,
                                //         ),
                                //       ).addDirectionality(),
                                //     ),
                                //   ],
                                // ),
                                // Obx(
                                //   () => Container(
                                //     height: 50,
                                //     decoration: BoxDecoration(
                                //         color: Colors.grey[100],
                                //         border: Border.all(
                                //             color: Colors.transparent),
                                //         borderRadius:
                                //             BorderRadius.circular(10)),
                                //     child: DropdownButton(
                                //         underline: Container(),
                                //         dropdownColor: Colors.white,
                                //         hint: Container(
                                //             padding: const EdgeInsets
                                //                     .symmetric(
                                //                 horizontal: 10,
                                //                 vertical: 5),
                                //             child: Text(
                                //               "نوع الحيوان",
                                //               style: TextStyle(
                                //                 fontSize: 18,
                                //                 color: Colors.grey,
                                //                 fontWeight:
                                //                     FontWeight.normal,
                                //               ),
                                //             ).addDirectionality()),
                                //         isExpanded: true,
                                //         icon: Icon(
                                //           Icons
                                //               .keyboard_arrow_down_outlined,
                                //           size: 24,
                                //         ),
                                //         value: _loginController
                                //             .selectedType.value,
                                //         items: types.map((e) {
                                //           return DropdownMenuItem(
                                //             child: Container(
                                //               padding: const EdgeInsets
                                //                       .symmetric(
                                //                   horizontal: 10,
                                //                   vertical: 0),
                                //               child: Row(
                                //                 children: [
                                //                   Expanded(
                                //                       child: Text(
                                //                     e,
                                //                     style: TextStyle(
                                //                       fontSize: 18,
                                //                       color: Colors.black,
                                //                       fontWeight:
                                //                           FontWeight
                                //                               .normal,
                                //                     ),
                                //                   )),
                                //                 ],
                                //               ),
                                //             ),
                                //             value: e,
                                //           );
                                //         }).toList(),
                                //         onChanged: (value) {
                                //           _loginController
                                //               .selectedType.value = value;
                                //         }),
                                //   ).addDirectionality(),
                                // ),
                                // SizedBox(height: 10),
                                ,
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                  validator: (value) => value!.trim().isEmpty
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
                                  controller: _loginController.phoneController,
                                  keyboardType: TextInputType.phone,
                                  // maxLength: 11,
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                  validator: (value) => value!.trim().isEmpty
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
                                  controller: _loginController.notesController,
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
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                  validator: (value) => value!.trim().isEmpty
                                      ? "يجب عليك ادخال ملاحظات"
                                      : null,
                                ).addDirectionality(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              height: 60.0,
                              width: 200,
                              child: RaisedButton(
                                color: Get.theme.accentColor,
                                onPressed: () {
                                  if (_loginController.selectedPet.value.id !=
                                      null) {
                                    if (_formKey.currentState!.validate()) {
                                      // if (_loginController.phoneController!.text
                                      //         .toString()
                                      //         .length ==
                                      //     11)
                                      // {
                                      _loginController.bookServices(item!.id);
                                    }
                                    // else {
                                    //   // Toast.show(validEmail(), Get.context,
                                    //   //     duration: Toast.LENGTH_LONG,
                                    //   //     gravity: Toast.BOTTOM);
                                    //   Get.snackbar("ادخل رقم هاتف صحيح",
                                    //       "ادخل رقم هاتف صحيح",
                                    //       duration: Duration(seconds: 3),
                                    //       icon: Icon(
                                    //         Icons.info,
                                    //         color: Colors.white,
                                    //       ),
                                    //       colorText: Colors.white,
                                    //       backgroundColor: Get
                                    //           .theme.primaryColorDark
                                    //           .withOpacity(0.3));
                                    //   // }
                                    // }
                                  } else {
                                    Get.snackbar(
                                        "أدخل اسم الحيوان", "أدخل اسم الحيوان",
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
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
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
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        )));
  }
}
