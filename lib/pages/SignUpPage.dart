// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_food/Service/auth_service.dart';
import 'package:next_food/pages/SignInPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  AuthClass authClass = AuthClass();

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
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem('Continue with Google', 'assets/google.svg', 30,
                  () async {
                authClass.googleSignIn(context);
              }),
              SizedBox(
                height: 15,
              ),
              buttonItem('Continue with Mobile', 'assets/phone.svg', 30, () {}),
              SizedBox(
                height: 15,
              ),
              Text(
                'Or',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              textItem('Email...', _emailController, false),
              SizedBox(
                height: 15,
              ),
              textItem('Password...', _passwordController, true),
              SizedBox(
                height: 30,
              ),
              colorButton(() async {
                authClass.emailSignUp(
                    context, _emailController.text, _passwordController.text);
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'If you already have an account?',
                    style: TextStyle(
                      color: Colors.white,
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
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

  Widget buttonItem(
      String text, String icon, double size, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          elevation: 8, // Shadow of the Card
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // obsureText is used to hide the password.
  Widget textItem(
      String labelText, TextEditingController controller, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.amber,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      // () async {
      //   setState(() {
      //     isLoading = true;
      //   });

      //   try {
      //     // Create a user with the email rand password.
      //     firebase_auth.UserCredential userCredential =
      //         await firebaseAuth.createUserWithEmailAndPassword(
      //             email: _emailController.text,
      //             password: _passwordController.text);
      //     // print(userCredential.user.email);
      //     setState(() {
      //       isLoading = false;
      //     });
      //     Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (builder) => HomePage()),
      //       (route) => false,
      //     );
      //   } on firebase_auth.FirebaseAuthException catch (e) {
      //     // Show the error message to the user.
      //     final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);

      //     setState(() {
      //       isLoading = false;
      //     });
      //   }
      // },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfffd746c),
              Color(0xffff9068),
              Color(0xfffd746c),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
