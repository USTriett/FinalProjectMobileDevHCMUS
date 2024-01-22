
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:next_food/Widgets/components/food_card.dart';

import '../DAO/food_dao.dart';
import '../DAO/history_dao.dart';
import '../DAO/question_dao.dart';
import 'collections.dart';

class DataManager{
  static Future<void> UpdateUser(String? email)async{
    if(email == null) {
      return;
    }
  }

  static getUserId() {
    return null;
  }

  static List<FoodCard> getCards(userId) {
    return [FoodCard(FoodDAO("bún riêu", [false, true, false, true], "assets/bun_rieu.jpg", 0, "Bún riêu gất ngon")),
      FoodCard(FoodDAO("bún mắm", [false, true, false, true], "assets/bun_rieu.jpg", 0, "Bún mắm gất ngon")),
      FoodCard(FoodDAO("bún đậu", [false, true, false, true], "assets/bun_rieu.jpg", 0, "Bún đậu gất ngon")),
    ];
  }

  //create more static class
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<List<QuestionDAO>> getAllQuestion() async {
    final snapShot = await Collection.questionsRef.get();
    final questionsData = snapShot.docs.map((e) => QuestionDAO.fromSnapShot(e)).toList();
    return questionsData;
  }

  static Future<String> getAnswer() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? id = auth.currentUser?.uid;
    final curUser = Collection.userRef;
    final snapShot = await curUser.doc(id).get();
    String ans = '';
    List<dynamic> data = snapShot['answers'];
    ans = data.map((e) => e.toString()).toList().join(" ");
    print(ans);
    return ans;
  }
  static Future<void> increaseFoodMatch(FoodDAO food)async {
    final foodCollection = Collection.foodRef;
    List<String> answersMap = [];
    int mcount = await getMatchCount(food.id);
    foodCollection.doc(food.id).update({"mactch_count" : ++mcount})
        .onError((e, _) => print("Error writing document: $e"));

  }

  static Future<List<HistoryDAO>> getHistory() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String? id = auth.currentUser?.uid;
    final curUser = Collection.userRef;
    final snapshot = await curUser.doc(id).get();
    List<dynamic>? currentList = snapshot.data()?['history'];
    // List<HistoryDAO> histories = currentList == null ? [] : currentList.map((e) => e.toString());
  }

  static Future<void> addHistory(HistoryDAO history) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String? id = auth.currentUser?.uid;
    final curUser = Collection.userRef;
    final snapshot = await curUser.doc(id).get();
    List<dynamic>? currentList = snapshot.data()?['history'];
    currentList ??= [];
    currentList.add(history.toJson());
    curUser.doc(id).update({"history": currentList});
  }

  static Future<void> updateAnswer(List<QuestionDAO> answers) async{
      FirebaseAuth auth = FirebaseAuth.instance;
      String? id = auth.currentUser?.uid;
      final curUser = Collection.userRef;
      List<String> answersMap = [];
      for (QuestionDAO q in answers) {
        answersMap.add(q.answer);
      }
        curUser.doc(id).update({"answers" : answersMap})
            .onError((e, _) => print("Error writing document: $e"));
      await getAnswer();
  }

  static Future<int> getMatchCount(String fid) async{
    final foodCollection = Collection.foodRef;
    final snapShot = await foodCollection.where("", isEqualTo: fid).get();
    FoodDAO food = snapShot.docs.map((e) => FoodDAO.fromSnapShot(e)).single;
    return food.matchedNums;
  }
}
