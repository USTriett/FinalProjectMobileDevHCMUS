import 'dart:math';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:next_food/Bloc/Events/navbar_events/navbar_events.dart';
import 'package:next_food/Bloc/States/navbar_states/navbar_states.dart';
import 'package:next_food/Bloc/navbar_bloc.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/pages/HistoryPage.dart';
import 'package:next_food/Widgets/pages/HomePage.dart';
import 'package:next_food/Widgets/pages/RandomPage.dart';

import 'package:next_food/Widgets/pages/SettingPage.dart';

import 'package:next_food/Widgets/pages/SignInPage.dart';
import 'package:next_food/Widgets/pages/SignUpPage.dart';
import 'package:next_food/nextfood_icons.dart';
import '../../DAO/food_dao.dart';
import '../../Values/constants.dart';


class NavBarComponent extends StatefulWidget {
// Private constructor
  static const int HOME_PAGE_TAB = 0;
  static const int RANDOM_PAGE_TAB = 1;
// static const int HOME_PAGE_TAB = 1;
// static const int HOME_PAGE_TAB = 1;

  NavBarComponent._internal() : super(key: WidgetKey.navBarKey);
  final screens = [
    HomePage(),
    RandomPage(foods: DAO.foods),

    SignInPage(),
    HistoryPage(),
    SettingPage(),
  ];
// Static instance variable
  static final NavBarComponent _instance = NavBarComponent._internal();

// Static method to access the single instance
  static NavBarComponent getInstance(int tabID){
    currentTab = tabID;
    _instance.createState();
    return _instance;

  }
  static int currentTab = 0;
  @override
  State<NavBarComponent> createState() => NavBar.fromPage(currentTab);

}

class NavBar extends State<NavBarComponent> {
  int page = 0;

  NavBar();
  NavBar.fromPage(int i){
    page = i;
  }


  void setPage(int tabID){
    CurvedNavigationBarState? navBarState =
        WidgetKey.bottomNavigationKey.currentState;
    navBarState?.setPage(page);
    // print("current tab2: ${page}");
    bool isShake = true;
    if(tabID != NavBarComponent.RANDOM_PAGE_TAB){
      isShake = false;
    }
    WidgetKey.randomPageKey?.currentState?.setShakeAvailable(isShake);

  }

  @override
  Widget build(BuildContext context) {

    Widget navBar = CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      key: WidgetKey.bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.home, size: 30, color: ThemeConstants.backgroundColor),
        Icon(FontAwesomeIcons.faceGrinSquintTears, size: 30, color: ThemeConstants.backgroundColor),
        Icon(Nextfood.nextFoodIcon, size: 40, color: Colors.black),
        Icon(FontAwesomeIcons.clockRotateLeft, size: 30, color: ThemeConstants.backgroundColor),
        Icon(Icons.settings, size: 30, color: ThemeConstants.backgroundColor),
      ],
      color: ThemeConstants.buttonTextColor,
      buttonBackgroundColor: ThemeConstants.buttonTextColor,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 400),
      onTap: (index) {
        setState(() {
          page = index;
        });
      },
      letIndexChange: (index) => true,
    );
    CurvedNavigationBarState? navBarState =
        WidgetKey.bottomNavigationKey.currentState;
    navBarState?.setPage(page);
    return SafeArea(
      top: true,
      child: Scaffold(
        extendBody: false,
        bottomNavigationBar: navBar,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: widget.screens[page]

          )
        ),
      );
  }
}