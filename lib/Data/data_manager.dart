import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:next_food/DAO/user_dao.dart';
import 'package:next_food/Widgets/components/food_card.dart';

import '../DAO/food_dao.dart';

class DataManager {
  static final DataManager _instance = DataManager._internal();

  factory DataManager() {
    return _instance;
  }

  DataManager._internal() {
    // initialization logic
  }

  final db = FirebaseFirestore.instance;

  Future<void> CreateUser(
      BuildContext context, UserCredential userCredential, String name) async {
    try {
      await db
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({"name": name});
    } catch (e) {
      // delete the user if the name is not set.
      await userCredential.user!.delete();

      final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<UserDAO?> GetUser(BuildContext context, String id) async {
    try {
      DocumentSnapshot doc = await db.collection("Users").doc(id).get();
      return UserDAO.fromMapObject(doc.data() as Map<String, dynamic>);
    } catch (e) {
      final SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static Future<void> UpdateUser(String? email) async {
    if (email == null) {
      return;
    }
  }

  static getUserId() {
    return null;
  }

  static List<FoodCard> getCards(userId) {
    return [
      FoodCard(FoodDAO("bún riêu", [false, true, false, true],
          "assets/bun_rieu.jpg", 0, "Bún riêu gất ngon")),
      FoodCard(FoodDAO("bún mắm", [false, true, false, true],
          "assets/bun_rieu.jpg", 0, "Bún mắm gất ngon")),
      FoodCard(FoodDAO("bún đậu", [false, true, false, true],
          "assets/bun_rieu.jpg", 0, "Bún đậu gất ngon")),
    ];
  }

  //create more static class
}
