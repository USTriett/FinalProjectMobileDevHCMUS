import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:next_food/Bloc/swiper_bloc.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/DAO/question_dao.dart';
import 'package:next_food/Widgets/components/food_card.dart';
import 'package:next_food/Widgets/components/foods_swiper.dart';
import 'package:next_food/Widgets/components/logo.dart';
import 'package:next_food/Widgets/components/tutorial_swipe_component.dart';
import 'package:next_food/Widgets/pages/MapPage.dart';

class FindFoodPage extends StatefulWidget {
  late String req;
  final List<FoodDAO> foods;
  final List<QuestionDAO> questions;

  FindFoodPage(
      {super.key,
      required this.foods,
      required this.questions,
      required this.req});

  @override
  _FindFoodPageState createState() => _FindFoodPageState();
}

class _FindFoodPageState extends State<FindFoodPage> {
  late bool isShowDialog = (widget.req == "") ? true : false;

  late String buffer = (widget.req == "") ? quesReq.toString() : widget.req;

  late ListQuestionDAO quesReq = ListQuestionDAO(questions: widget.questions);

  Map<String, dynamic> foodList = {};

  Map<String, String> matchFood = {
    "Vietnamese bread soup": "Bánh canh",
    "Vietnamese noodle soup with beef dish": "Bún bò Huế",
    "Vietnamese pancake dish": "Bánh xèo",
    "Vietnamese barbecue pork with vermicelli dish": "Bún thịt nướng",
    "Vietnamese Quang noodle dish": "Mì quảng",
    "Vietnamese kebab rice noodles dish": "Bún chả",
    "Spaghetti dish": "Mì ý",
    "Vietnamese banh mi dish": "Bánh mì",
    "Vietnamese broken rice dish": "Cơm tấm",
    "Dumpling dish": "Sủi cảo",
    "Vietnamese braised beef dish": "Bò kho",
  };

  Future<void> fetchListFood() async {
    final response = await http
        .get(Uri.parse('https://harryle1203.pythonanywhere.com/soup'));

    if (response.statusCode == 200) {
      setState(() {
        foodList = json.decode(response.body);
      });
    } else {
      print('Failed to fetch food data.');
    }
  }

  late List<FoodDAO> newfoods = List.generate(
    matchFood.length,
    (index) => widget.foods.firstWhere(
        (food) => food.name == matchFood["${foodList["$index"]}"],
        orElse: () => FoodDAO("", [], "", 0, "")),
  );

  late List<FoodDAO> currentFoods = List.generate(
    matchFood.length,
    (index) => widget.foods.firstWhere(
        (food) => food.name == matchFood["${foodList["$index"]}"],
        orElse: () => FoodDAO("", [], "", 0, "")),
  );

  

  @override
  Widget build(BuildContext context) {
    GlobalKey<FoodSwiperState> _childKey = GlobalKey<FoodSwiperState>();

    List<FoodCard> cards =
        currentFoods.map((foodDAO) => FoodCard(foodDAO)).toList();

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.req == "" && isShowDialog == true) {
        quesReq.showQuestionsPopup(context, fetchListFood);
        isShowDialog = false;
        }
        // fetchListFood;
      });
    

    FoodSwiper swiper = FoodSwiper(
      key: _childKey,
      context: context,
      foodCards: cards,
      like: () {
        setState(() {
          currentFoods.removeAt(0);
          cards.removeAt(0);
          if (currentFoods.length < newfoods.length / 2) {
            currentFoods.addAll(newfoods);
          }
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapPage(food: currentFoods[0])));
      },
      dislike: () {
        setState(() {
          currentFoods.removeAt(0);
          cards.removeAt(0);
          if (currentFoods.length < (newfoods.length / 2)) {
            currentFoods.addAll(newfoods);
          }
        });
      },
    );


    return Scaffold(
      body: Center(
          child: BlocProvider<SwiperBloc>(
              create: (context) => SwiperBloc(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: AppLogoWidget(),
                  ),
                  Container(
                      height: 450,
                      padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                      // color: Colors.green,
                      alignment: Alignment.center,
                      child: swiper),
                  SwipeTutorialComponent(
                    height: 100,
                    width: 100,
                  )
                ],
              ))),
      // Các phần khác của giao diện người dùng (UI) của trang FindFoodPage
    );
  }
}
