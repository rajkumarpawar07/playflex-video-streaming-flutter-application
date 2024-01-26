import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:login_flutter_app/pages/explore.dart';
import 'package:login_flutter_app/pages/home_page.dart';
import 'package:login_flutter_app/pages/liked.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/profile/profile_screen.dart';
import 'package:login_flutter_app/utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();

  // static handleCommand(Map<String, dynamic> responce) {
  //   switch (responce["command"]) {
  //     case "Trending page":
  //       onTap(2);
  //       break;
  //     default:
  //       print("you entered ${responce["command"]}");
  //   }
  // }
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const ExplorePage(),
    const Liked(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void handleCommand(Map<String, dynamic> responce) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: BottomNavigationBar(
              currentIndex: currentIndex,
              backgroundColor: Colors.black.withOpacity(.1),
              type: BottomNavigationBarType.fixed,
              onTap: onTap,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade500,
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore_outlined),
                    activeIcon: Icon(Icons.explore_rounded),
                    label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    activeIcon: Icon(Icons.favorite),
                    label: 'Liked'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    activeIcon: Icon(Icons.person_outline),
                    label: 'profile'),
              ]),
        ),
      ),
    );
  }
}
