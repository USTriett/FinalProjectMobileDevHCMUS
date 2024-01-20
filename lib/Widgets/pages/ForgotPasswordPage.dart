// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/pages/SignInPage.dart';

import '../components/color_button.dart';
import '../components/text_item.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  AuthClass authClass = AuthClass();

  @override
  void dispose() {
    _emailController.dispose();
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
          color: ThemeConstants.backgroundColor,
          child: Column(
            // Align the children to the center of the screen.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: ThemeConstants.titleStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Enter your email to get reset password link',
                style: TextStyle(
                  color: ThemeConstants.textColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              textItem(context, 'Email...', _emailController, false),
              SizedBox(
                height: 20,
              ),
              colorButton(context, "Send verify email", () async {
                authClass.passwordReset(context, _emailController.text.trim());
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already reset your password?',
                    style: TextStyle(
                      color: ThemeConstants.textColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => SignInPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: ThemeConstants.subTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
