import 'package:next_food/Widgets/components/food_card.dart';

import '../DAO/food_dao.dart';

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

}