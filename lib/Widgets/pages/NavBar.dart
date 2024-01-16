import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/pages/HomePage.dart';

import 'package:next_food/Widgets/pages/SignInPage.dart';
import 'package:next_food/Widgets/pages/SignUpPage.dart';
import 'package:next_food/nextfood_icons.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final screens = [
    HomePage(),
    SignUpPage(),
    SignInPage(),
    HomePage(),
    SignUpPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        top: true,
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.home, size: 30, color: ThemeConstants.backgroundColor,),
              Icon(FontAwesomeIcons.faceGrinSquintTears, size: 30, color: ThemeConstants.backgroundColor,),
              Icon(Nextfood.nextFoodIcon, size: 40, color: Colors.black,),
              Icon(FontAwesomeIcons.clockRotateLeft, size: 30, color: ThemeConstants.backgroundColor,),
              Icon(Icons.settings, size: 30, color: ThemeConstants.backgroundColor,),
            ],
            color: ThemeConstants.buttonTextColor,
            buttonBackgroundColor: ThemeConstants.buttonTextColor,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: screens[_page]),
      )

    );
}

  // @override
  // Widget build(BuildContext context){
  //   return MaterialApp(
  //     home: Scaffold(
  //       backgroundColor: Colors.blue,
  //       appBar: AppBar(
  //         title: Text('Curved Nav Bar', textDirection: TextDirection.rtl,),
  //         elevation: 0,
  //         centerTitle: true,
  //       ),
  //       body: Container(),
  //     ),
  //   );
  // }
}

