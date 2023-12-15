import 'package:chat_app/Modules/Views/Home_Screen/View/home_screen.dart';
import 'package:chat_app/Modules/Views/Intro_Screen/Views/Intro_screen.dart';
import 'package:chat_app/Modules/Views/Login_screen/Views/Login_Screen.dart';
import 'package:chat_app/Modules/Views/Splash_screen/Views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Modules/Views/SignUp_Screen/View/signup_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      GetPage(
        name: '/signup',
        page: () => SignUp_Page(),
      ),
      GetPage(
        name: '/home',
        page: () => Home_Screen(),
      ),
    ],
  ));
}
