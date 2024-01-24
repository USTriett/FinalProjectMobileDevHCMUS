import 'package:next_food/Data/data_manager.dart';

class Collection {
  static final foodRef = DataManager.db.collection("Foods");
  static final questionsRef = DataManager.db.collection("Q&A");
  static final userRef = DataManager.db.collection("Users");
  static final categoryRef = DataManager.db.collection("Categories");
}
