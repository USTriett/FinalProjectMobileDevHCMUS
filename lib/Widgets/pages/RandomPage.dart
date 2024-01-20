import 'dart:ui';

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

class RandomPageState extends State<RandomPage> with SingleTickerProviderStateMixin{
  bool isPopupVisible = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 8.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Stack(
        children: [



          // Widget popup
          AnimatedOpacity(
            opacity: isPopupVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.white,
                child: Text('Popup Content'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isPopupVisible = true;
              });
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _animation.value, sigmaY: _animation.value),
                child: Container(
                  color: Colors.black.withOpacity(_animation.value / 8),
                ),
              );
            },
          ),
        ]
      ),
    );
  }

}

