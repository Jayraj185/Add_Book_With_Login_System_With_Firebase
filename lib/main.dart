import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:login_project/Screens/AddBookScreen/View/AddBookPage.dart';
import 'package:login_project/Screens/BookViewScreen/View/BookViewPage.dart';
import 'package:login_project/Screens/HomeScreen/View/HomePage.dart';
import 'package:login_project/Screens/SighUpScreen/View/SighUpPage.dart';
import 'package:login_project/Screens/SignInScreen/View/SignInPage.dart';
import 'package:login_project/Screens/SplashScreen/View/SplashPage.dart';
import 'package:sizer/sizer.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/' : (context) => SplashPage(),
            'SignIn' : (context) => SignInPage(),
            'SignUp' : (context) => SignUpPage(),
            'Home' : (context) => HomePage(),
            'AddBook' : (context) => AddBookPage(),
            'ViewBook' : (context) => BookViewPage(),
          },
        );
      },
    )
  );
}