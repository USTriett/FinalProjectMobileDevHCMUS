import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:next_food/Bloc/States/swiper_states/swiper_states.dart';
import 'package:next_food/Bloc/swiper_bloc.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/Data/data_manager.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
import 'package:next_food/Widgets/components/food_card.dart';
import 'package:next_food/Widgets/components/foods_swiper.dart';
import 'package:next_food/Widgets/components/logo.dart';
import 'package:next_food/Widgets/pages/NavBar.dart';
import 'package:next_food/Widgets/pages/SignInPage.dart';
import 'package:next_food/nextfood_icons.dart';


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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NavBar(),
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

