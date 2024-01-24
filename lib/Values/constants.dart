import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:next_food/Widgets/components/question_item.dart';

import '../DAO/food_dao.dart';
import '../DAO/history_dao.dart';
import '../DAO/question_dao.dart';
import '../Widgets/pages/NavBar.dart';
import '../Widgets/pages/RandomPage.dart';

class AppImagePath{
  static String facebook = "assets/icons8-google.svg";
  static String google = "assets/icons8-google.svg";

}
class AnimationConstants{
  static const double initAnimationOffset = 100;
  static const double cardHeight = 220;

  static const double dragStartEndAngle = 0.01;

  static const double rotationAnimationAngleDeg = 360;

  static const double scaleFraction = 0.05;
  static const double yOffset = 13;

  static const double throwSlideYDistance = 200;

  static const Duration backgroundCardsAnimationDuration = Duration(milliseconds: 300);
  static const Duration swipeAnimationDuration = Duration(milliseconds: 500);
}

class WidgetKey{
  static GlobalKey<NavBar> navBarKey = GlobalKey();
  static GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  static GlobalKey<RandomPageState> randomPageKey = GlobalKey();
  static GlobalKey<QuestionWidgetState> quesStateKey = GlobalKey();
}

class DAO{
  static List<QuestionDAO> list = [];
  static List<FoodDAO> foods =[];
  static List<HistoryDAO> history = [];
}