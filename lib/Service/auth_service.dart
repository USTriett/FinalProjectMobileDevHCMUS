import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:next_food/Data/sqlite_data.dart';
import 'package:next_food/Widgets/components/popup_question.dart';
import 'package:next_food/Widgets/pages/SplashScreen.dart';
import 'package:next_food/Widgets/pages/VerifyEmailPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Widgets/pages/SignInPage.dart';

class AuthClass {
  FirebaseAuth auth = FirebaseAuth.instance;
  // final storage = const FlutterSecureStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isUserSignedIn() {
    print("emaillll: ${auth.currentUser!.email}");
    return auth.currentUser != null;
  }

  bool isUserVerified() {
    return auth.currentUser!.emailVerified;
  }

  // Email & Password Sign Up
  Future<void> emailSignUp(BuildContext context, String name, String email,
      String password, String confirmPassword) async {
    if (password != confirmPassword) {
      final SnackBar snackBar =
          SnackBar(content: Text("Passwords do not match"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    try {
      // Create a user with the email rand password.
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // create an user with name
      try {
        firestore
            .collection("Users")
            .doc(userCredential.user!.uid)
            .set({"name": name});
      } catch (e) {
        // delete the user if the name is not set.
        await userCredential.user!.delete();

        final SnackBar snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      // storeTokenAndData(userCredential);

      // setState(() {
      //   isLoading = false;
      // });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => VerifyEmailPage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // Show the error message to the user.
      final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  // Email & Password Sign In
  Future<void> emailSignIn(
      BuildContext context, String email, String password) async {
    // setState(() {
    //   isLoading = true;
    // });

    try {
      // Sign in the user with the email and password.
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      // storeTokenAndData(userCredential);
      // setState(() {
      //   isLoading = false;
      // });

      bool isVerified = auth.currentUser!.emailVerified;
      // if (isVerified) await SqliteData.insertAllData();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (builder) =>
                isVerified ? SplashScreen() : VerifyEmailPage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // Show the error message to the user.
      final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  // GG Sign In
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> googleSignIn(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      try {
        // Once signed in, return the UserCredential
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        // await SqliteData.insertAllData();

        // create an user with name
        try {
          // check if the user already exists in the firestore
          final DocumentSnapshot documentSnapshot = await firestore
              .collection("Users")
              .doc(userCredential.user!.uid)
              .get();

          // if the user does not exist, create a new user with the name
          if (!documentSnapshot.exists) {
            firestore
                .collection("Users")
                .doc(userCredential.user!.uid)
                .set({"name": userCredential.user!.displayName});
          }
        } catch (e) {
          // delete the user if the name is not set.
          await userCredential.user!.delete();

          final SnackBar snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        // Store the token and user data in the storage to keep the user logged in.
        // storeTokenAndData(userCredential);

        // await SqliteData.insertAllData();
        // remove the previous page from the stack and navigate to the home page.
        await SqliteData.insertAllData();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => SplashScreen()),
          (route) => false,
        );
      } catch (e) {
        // Show the error message to the user.
        final SnackBar snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // Show the error message to the user.
      final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // Future<void> storeTokenAndData(UserCredential userCredential) async {
  //   String? token = userCredential.user!.uid;
  //   await storage.write(key: "token", value: token);
  //   await storage.write(
  //       key: "userCredential", value: userCredential.toString());
  // }

  // Future<String?> getToken() async {
  //   String? token = await storage.read(key: "token");
  //   return token;
  // }

  Future<void> logout(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      // await storage.delete(key: "token");
      // await storage.deleteAll();

      await SqliteData.deleteDatabaseFile();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => SignInPage()),
        (route) => false,
      );
    } catch (e) {
      final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future passwordReset(BuildContext context, String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      SnackBar snackBar = SnackBar(content: Text('Email sent'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future sendVerificationEmail(BuildContext context) async {
    final user = auth.currentUser;
    if (!user!.emailVerified) {
      try {
        await user.sendEmailVerification();
        SnackBar snackBar = SnackBar(content: Text('Email sent'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        SnackBar snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
