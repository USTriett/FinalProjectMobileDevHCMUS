import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_food/Bloc/States/swiper_states/swiper_states.dart';
import 'package:next_food/Bloc/swiper_bloc.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/Data/data_manager.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
import 'package:next_food/Widgets/components/food_card.dart';
import 'package:next_food/Widgets/components/foods_swiper.dart';
import 'package:next_food/Widgets/components/logo.dart';


import 'Widgets/pages/HomePage.dart';
import 'Widgets/pages/SignUpPage.dart';
import 'firebase_options.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:next_food/Service/auth_service.dart';


void main() async {
  // // All widgets need to be initialized before they can be used.

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase.
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Container(
              height: 50,
              child: Column(
                children: [Icon(Icons.add, size: 30), Text("page 1")],
              ),
            ),
            Container(
              height: 50,
              child: Column(
                children: [Icon(Icons.list, size: 30), Text("page 2")],
              ),
            ),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                ElevatedButton(
                  child: Text('go to page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState? navbarstate =
                        _bottomNavigationKey.currentState;
                    navbarstate?.setPage(1);
                  },
                )
              ],
            ),
          ),
        ))

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

