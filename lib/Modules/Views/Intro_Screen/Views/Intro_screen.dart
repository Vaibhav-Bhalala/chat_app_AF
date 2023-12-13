import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffCDCBFF),
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
              title: "Do Realtime Messaging",
              body: "Chat with your contacts at real time",
              image: Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("lib/Modules/Assets/Images/intro_1.png"),
                    ),
                  ),
                ),
              )),
          PageViewModel(
              title: "Send Photos and Videos",
              body: "Share images and videos to your contacts and friends",
              image: Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("lib/Modules/Assets/Images/intro_2.jpg"),
                    ),
                  ),
                ),
              )),
          PageViewModel(
              title: "Connect with Friends and Family",
              body: "Connect and talk with them at any time and From Anywhere",
              image: Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("lib/Modules/Assets/Images/intro_3.jpeg"),
                    ),
                  ),
                ),
              )),
        ],
        done: Text("Done"),
        onDone: () async {
          // SharedPreferences preferences = await SharedPreferences.getInstance();
          // preferences.setBool("isIntroVisited", false);
          Get.offAllNamed('/splash');
        },
        next: Text("Next"),
        showNextButton: true,
      ),
    );
  }
}
