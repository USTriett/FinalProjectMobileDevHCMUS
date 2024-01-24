// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:next_food/Data/sqlite_data.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/Widgets/pages/HomePage.dart';
import 'package:next_food/Widgets/pages/SplashScreen.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  Timer? timer;
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    if (firebaseAuth.currentUser!.emailVerified) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const HomePage()),
        (route) => false,
      );
    } else {
      authClass.sendVerificationEmail(context);

      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        auth.currentUser!.reload();

        if (auth.currentUser!.emailVerified) {
          timer.cancel();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const SplashScreen()),
            (route) => false,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // Use MediaQuery to get the screen size.
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            // Align the children to the center of the screen.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verify Email',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Open your email and click on the link we\nsent you to verify your email address.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  authClass.logout(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
