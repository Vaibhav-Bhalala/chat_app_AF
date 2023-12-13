import 'package:chat_app/Modules/Views/Intro_Screen/Views/Intro_screen.dart';
import 'package:chat_app/Modules/Views/Login_screen/Views/Login_Screen.dart';
import 'package:chat_app/Modules/Views/Splash_screen/Views/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    initialRoute: '/intro',
    getPages: [
      GetPage(
        name: '/',
        page: () => LoginScreen(),
      ),
      GetPage(
        name: '/intro',
        page: () => IntroScreen(),
      ),
      GetPage(
        name: '/splash',
        page: () => SplashScreen(),
      ),
    ],
  ));
}
