import 'package:flutter/material.dart';
import 'package:next_food/Service/local_storage.dart';

import 'package:next_food/Widgets/pages/VerifyEmailPage.dart';

import 'Widgets/pages/HomePage.dart';
import 'Widgets/pages/SignInPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:next_food/Service/auth_service.dart';

void main() async {
  // All widgets need to be initialized before they can be used.

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase.
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const SignInPage();
  AuthClass authClass = AuthClass();
  LocalStorage localStorage = LocalStorage();

  void checkLogin() async {
    String? token = await localStorage.getToken();
    bool isVerified = await authClass.isEmailVerified();

    if (token != null) {
      setState(() {
        currentPage = (isVerified ? const HomePage() : const VerifyEmailPage());
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
    ));
  }
}
