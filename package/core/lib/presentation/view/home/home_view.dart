import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:restaurant/restaurant.dart';

import '../../../core.dart';

class NavbarItem {
  IconData icon, activeIcon;
  String label;

  NavbarItem(this.icon, this.activeIcon, this.label);
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  PageController pageController = PageController();
  int currentTab = 0;
  final List<Widget> bodyContent = [
    const RestaurantHomeView(),
    const RestaurantFavoriteView(),
    const SettingView(),
  ];
  List<NavbarItem> navbarItem = [
    NavbarItem(Icons.home, Icons.home, 'Home'),
    NavbarItem(Icons.favorite, Icons.favorite, 'Favorite'),
    NavbarItem(Icons.settings, Icons.settings, 'Setting')
  ];

  openTab(int index) {
    if (index != 1) {
      setState(() {
        currentTab = index;
        pageController.jumpToPage(currentTab);
      });
    }
  }

  void onPageChanged(index) {
    if (currentTab != index) {
      pageController.jumpToPage(index);
      setState(() => currentTab = index);
    }
  }

  void navigatePageNotification() {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      print('Ini RemoteMessage $message');
      if(message != null){
        String pageName = message.data['page_name'];
        String id = message.data['id'];
        Navigator.of(context).pushNamed(pageName, arguments: id);
      }
    });
  }

  @override
  void initState() {
    Future.microtask(() {
      navigatePageNotification();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: false,
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          ),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: onPageChanged,
            children: bodyContent,
          ),
        ),
        BottomNavigationBar(
          selectedFontSize: 12.dp,
          unselectedFontSize: 12.dp,
          currentIndex: currentTab,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          onTap: onPageChanged,
          items: navbarItem.map((e) {
            final index = navbarItem.indexOf(e);
            return BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.dp),
                child: Icon(
                  index == currentTab ? e.activeIcon : e.icon,
                  color: index == currentTab ? AppColors.primary : AppColors.grey,
                  size: 16.dp,
                ),
              ),
              label: e.label,
            );
          }).toList(),
        ),
      ],
    );
  }
}
