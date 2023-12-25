import 'package:chat_app/Modules/Views/Home_Screen/View/Pages/chat_tab.dart';
import 'package:chat_app/Modules/Views/Home_Screen/View/Pages/people_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/navigation_controller.dart';
import 'Pages/settings_tab.dart';

class Home_Screen extends StatelessWidget {
  Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController data = Get.put(NavigationController());
    List<Widget> PageList = [
      chats(),
      people(),
      settings(),
    ];
    return Scaffold(
      bottomNavigationBar: GetBuilder<NavigationController>(
        builder: (_) => NavigationBar(
          selectedIndex: data.navigationModel.selectedIndex.value,
          onDestinationSelected: (val) {
            data.changeTab(val: val);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.wechat_sharp),
              label: "Chats",
            ),
            NavigationDestination(
              icon: Icon(Icons.people),
              label: "People",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: GetBuilder<NavigationController>(
        builder: (_) => PageView(
          onPageChanged: (val) {
            data.changeTab(val: val);
          },
          controller: data.pageController,
          children: PageList,
        ),
      ),
    );
  }
}
