import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_project/Screens/AddBookScreen/Model/BookDataModel.dart';
import 'package:login_project/Screens/AddBookScreen/View/AddBookPage.dart';
import 'package:login_project/Utils/FirebaseHelper/FirebaseHelper.dart';

class HomeController extends GetxController
{
  //Only Variable's
  TextEditingController txtSignInEmail = TextEditingController();
  TextEditingController txtSignInPass = TextEditingController();
  TextEditingController txtSignUpEmail = TextEditingController();
  TextEditingController txtSignUpPass = TextEditingController();
  TextEditingController txtBookName = TextEditingController();
  Rx<TextEditingController> txtBookImgLink = TextEditingController().obs;
  TextEditingController txtAuthorName = TextEditingController();
  TextEditingController txtAboutAuthor = TextEditingController();
  TextEditingController txtAboutBook = TextEditingController();
  TextEditingController txtBookRating = TextEditingController();
  TextEditingController txtBookPublishYear = TextEditingController();
  TextEditingController txtUpdateBookName = TextEditingController();
  Rx<TextEditingController> txtUpdateBookImgLink = TextEditingController().obs;
  TextEditingController txtUpdateAuthorName = TextEditingController();
  TextEditingController txtUpdateAboutAuthor = TextEditingController();
  TextEditingController txtUpdateAboutBook = TextEditingController();
  TextEditingController txtUpdateBookRating = TextEditingController();
  TextEditingController txtUpdateBookPublishYear = TextEditingController();
  TextEditingController txtBookCategoryName = TextEditingController();
  TextEditingController txtUpdateBookCategoryName = TextEditingController();
  GlobalKey<FormState> SignUpkey = GlobalKey<FormState>();
  GlobalKey<FormState> SignInkey = GlobalKey<FormState>();
  GlobalKey<FormState> AddBookkey = GlobalKey<FormState>();
  GlobalKey<FormState> AddCategorykey = GlobalKey<FormState>();
  RxBool SignUp_password_vis = true.obs;
  RxBool SignIn_password_vis = true.obs;
  RxList<BookDataModel> BooksList = <BookDataModel>[].obs;
  RxList CategoryList = [].obs;
  RxList<BookDataModel> BookDataList = <BookDataModel>[].obs;
  Rx<BookDataModel> bookDataModel = BookDataModel().obs;
  RxString Id = "".obs;
  RxInt Check = 0.obs;
  RxString DropDownValue = "".obs;
  RxInt TabIndex = 0.obs;



  //Only Function's

  Future<void> IsLogin()
  async {
    bool isLogin = await FirebaseHelper.firebaseHelper.CheckSignIn();
    print("===== $isLogin");
    if(isLogin)
      {
        Timer(Duration(seconds: 3), () {
          Get.offNamed('Home');
        });
      }
    else
      {
        Timer(Duration(seconds: 3), () {
          Get.offNamed('SignIn');
        });
      }
  }

  void GetData()
  {

  }

}