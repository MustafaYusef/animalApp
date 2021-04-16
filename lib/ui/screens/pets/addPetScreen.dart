import 'package:animal_app/controller/mainController/myPetsController.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/pets/selectImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';

class AddPetsScreen extends StatelessWidget {
  AddPetsScreen();
  MyPetsController _loginController = Get.put(MyPetsController());
  // ItemDetailsController cartController = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.delete<MyPetsController>();
        Get.back();
      },
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: Text(
              "إضافة حيوان",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ).addDirectionality(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
            // height: Get.height + 200,
            // width: Get.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => _loginController.imageFile.value == null
                        ? InkWell(
                            onTap: () {
                              selecteImageCollection(_loginController);
                            },
                            child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 20,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(75)),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                )))
                        : Container(
                            height: 150,
                            width: 150,
                            child: Stack(children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(75.0),
                                    ),
                                    child: Image.file(
                                      _loginController.imageFile.value,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              // Container(),
                              Positioned(
                                top: 55,
                                right: 55,
                                left: 55,
                                child: InkWell(
                                  onTap: () {
                                    selecteImageCollection(_loginController);
                                  },
                                  child: Container(
                                      // margin: EdgeInsets.all(10),
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.black,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ),
                              ),
                            ])),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey[300]),
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
                                TextFormField(
                                  controller:
                                      _loginController.petNameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      hintText: "أسم الحيوان",
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
                                  validator: (value) => value.trim().isEmpty
                                      ? "يجب عليك ادخال أسم الحيوان"
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
                                        "نوع الحيوان",
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
                                              "نوع الحيوان",
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
                                        value:
                                            _loginController.selectedType.value,
                                        items: types.map((e) {
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
                                                    e,
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
                                        onChanged: (value) {
                                          _loginController.selectedType.value =
                                              value;
                                        }),
                                  ).addDirectionality(),
                                ),
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
                                        "جنس الحيوان",
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
                                              "جنس الحيوان",
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
                                        value:
                                            _loginController.selectedSex.value,
                                        items: sexes.map((e) {
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
                                                    e,
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
                                        onChanged: (value) {
                                          _loginController.selectedSex.value =
                                              value;
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
                                        "العمر",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  // width: 120,
                                  // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: TextFormField(
                                    controller: _loginController.ageController,
                                    keyboardType: TextInputType.text,
                                    readOnly: true,
                                    onTap: () async {
                                      final DateTime picked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: _loginController
                                                  .selectedFromDate.value,
                                              firstDate: DateTime(1990),
                                              lastDate: DateTime(2050),
                                              cancelText: "خروج",
                                              confirmText: "تم");
                                      if (picked != null &&
                                          picked !=
                                              _loginController
                                                  .selectedAgeDate.value) {
                                        _loginController.selectedAgeDate.value =
                                            picked;
                                        _loginController
                                                .ageController.text =
                                            (_loginController.selectedAgeDate
                                                            .value.month
                                                            .toString()
                                                            .length <
                                                        2
                                                    ? "0" +
                                                        _loginController
                                                            .selectedAgeDate
                                                            .value
                                                            .month
                                                            .toString()
                                                    : _loginController
                                                        .selectedAgeDate
                                                        .value
                                                        .month
                                                        .toString()) +
                                                "-" +
                                                (_loginController
                                                            .selectedAgeDate
                                                            .value
                                                            .day
                                                            .toString()
                                                            .length <
                                                        2
                                                    ? "0" +
                                                        _loginController
                                                            .selectedAgeDate
                                                            .value
                                                            .day
                                                            .toString()
                                                    : _loginController
                                                        .selectedAgeDate
                                                        .value
                                                        .day
                                                        .toString()) +
                                                "-" +
                                                _loginController
                                                    .selectedAgeDate.value.year
                                                    .toString();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      hintText: "عمر الحيوان",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
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
                                      // contentPadding:EdgeInsets.all(10)
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
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
                                        "تاريخ آخر لقاح",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ).addDirectionality(),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  // width: 120,
                                  // margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  child: TextFormField(
                                    controller:
                                        _loginController.vacsinDateController,
                                    keyboardType: TextInputType.text,
                                    readOnly: true,
                                    onTap: () async {
                                      final DateTime picked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: _loginController
                                                  .selectedFromDate.value,
                                              firstDate: DateTime(1990),
                                              lastDate: DateTime(2050),
                                              cancelText: "خروج",
                                              confirmText: "تم");
                                      if (picked != null &&
                                          picked !=
                                              _loginController
                                                  .selectedFromDate.value) {
                                        _loginController
                                            .selectedFromDate.value = picked;
                                        _loginController
                                                .vacsinDateController.text =
                                            (_loginController.selectedFromDate
                                                            .value.month
                                                            .toString()
                                                            .length <
                                                        2
                                                    ? "0" +
                                                        _loginController
                                                            .selectedFromDate
                                                            .value
                                                            .month
                                                            .toString()
                                                    : _loginController
                                                        .selectedFromDate
                                                        .value
                                                        .month
                                                        .toString()) +
                                                "-" +
                                                (_loginController
                                                            .selectedFromDate
                                                            .value
                                                            .day
                                                            .toString()
                                                            .length <
                                                        2
                                                    ? "0" +
                                                        _loginController
                                                            .selectedFromDate
                                                            .value
                                                            .day
                                                            .toString()
                                                    : _loginController
                                                        .selectedFromDate
                                                        .value
                                                        .day
                                                        .toString()) +
                                                "-" +
                                                _loginController
                                                    .selectedFromDate.value.year
                                                    .toString();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      hintText: "تاريخ آخر لقاح",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
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
                                      // contentPadding:EdgeInsets.all(10)
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ).addDirectionality(),
                                ),
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
                                        "الوصف",
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
                                  controller: _loginController.descController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      hintText: "الوصف",
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
                                  // validator: (value) =>
                                  //     value.trim().isEmpty
                                  //         ? "يجب عليك ادخال أسم الحيوان"
                                  //         : null,
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
                                  if (_formKey.currentState.validate()) {
                                    _loginController.addPets();
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
                  SizedBox(
                    height: 30,
                  ),
                ]),
          ))),
    );
  }
}
