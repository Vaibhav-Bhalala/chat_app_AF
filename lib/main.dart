import 'package:chat_app/Modules/Views/Login_screen/Views/Login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    getPages: [
      GetPage(
        name: '/',
        page: () => LoginScreen(),
      )
    ],
  ));
}
