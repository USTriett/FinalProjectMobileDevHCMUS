import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_food/Themes/theme_constants.dart';

import '../../DAO/food_dao.dart';
import '../components/logo.dart';

class RandomPage extends StatefulWidget{
  final List<FoodDAO> foods;
  RandomPage({super.key, required this.foods});
  @override
  State<StatefulWidget> createState() => RandomPageState();

}

class RandomPageState extends State<RandomPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: GestureDetector(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: AppLogoWidget(),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Image.asset(
                'assets/restaurant.png',
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: const Text(
                  "Lắc điện thoại để chúng tôi làm món ăn cho bạn nhé",
                style: ThemeConstants.textStyleLarge,
                maxLines: 2,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              
              ),
            )
          ],
        ),
      ),
    );
  }

}