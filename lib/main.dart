import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/pages/HomePage.dart';
import 'package:next_food/pages/RandomPage.dart';
import 'package:next_food/pages/SignInPage.dart';
import 'package:next_food/pages/SignUpPage.dart';

void main() async {
  // All widgets need to be initialized before they can be used.
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
  Widget currentPage = const SignInPage();
  AuthClass authClass = AuthClass();

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: currentPage,
      // body: RandomPage(),
    ));
  }
}
