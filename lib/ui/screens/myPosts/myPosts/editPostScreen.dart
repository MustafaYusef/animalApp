import 'package:animal_app/controller/authController/myPostController.dart';
import 'package:animal_app/controller/mainController/myPetsController.dart';
import 'package:animal_app/controller/mainController/postController.dart';
import 'package:animal_app/metods/extentions.dart';
import 'package:animal_app/ui/screens/myPosts/selectImage.dart';
import 'package:animal_app/ui/screens/pets/selectImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant.dart';

class EditPostScreen extends StatelessWidget {
  EditPostScreen(String desc) {
    _loginController = Get.put(MyPostController());
    _loginController.descController.text = desc;
  }
  MyPostController _loginController;
  // ItemDetailsController cartController = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.delete<PostController>();
        Get.back();
      },
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: Text(
              "إضافة منشور",
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Obx(
                        () => _loginController.imageFile.value == null
                            ? InkWell(
                                onTap: () {
                                  selecteImagePost(_loginController);
                                },
                                child: Container(
                                    height: Get.width - 200,
                                    width: Get.width - 200,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 20,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt,
                                            size: 70,
                                            color: Get.theme.accentColor),
                                        Text(
                                          "أختر صورة",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Get.theme.accentColor),
                                        )
                                      ],
                                    )))
                            : Container(
                                height: Get.width - 200,
                                width: Get.width - 200,
                                child: Stack(children: [
                                  Container(
                                      height: Get.width - 200,
                                      width: Get.width - 200,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        child: Image.file(
                                          _loginController.imageFile.value,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  // Container(),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    // left: 55,
                                    child: InkWell(
                                      onTap: () {
                                        selecteImagePost(_loginController);
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
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                      controller:
                                          _loginController.descController,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      maxLines: null,
                                      // InputDecoration(
                                      // alignLabelWithHint: false,
                                      // filled: true,
                                      // hasFloatingPlaceholder: false,
                                      // border: new OutlineInputBorder(
                                      //   borderRadius: const BorderRadius.all(
                                      //     const Radius.circular(10.0),
                                      //   ),
                                      // ),
                                      // hintStyle: new TextStyle(color: Colors.grey[800]),
                                      // labelText: getTranslate('note'),
                                      // labelStyle: TextStyle(
                                      //   fontSize: 16,
                                      //   backgroundColor: Colors.white,
                                      // ),

                                      // prefixIcon: Icon(
                                      //   Icons.edit,
                                      //   color: Colors.black,
                                      // ),
                                      // contentPadding: EdgeInsets.all(7),
                                      // fillColor: Colors.white70)
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
                                        contentPadding: EdgeInsets.all(10),
                                        suffixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                // if (FocusScope.of(context2).isFirstFocus) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                // }
                                              },
                                              child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: Get
                                                          .theme.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Text(
                                                      "تم",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                        _loginController.editPost();
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
                  SizedBox(
                    height: 30,
                  ),
                ]),
          ))),
    );
  }
}
