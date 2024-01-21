import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/food_card.dart';
import 'package:next_food/Widgets/components/foods_swiper.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

import '../../Bloc/swiper_bloc.dart';
import '../../DAO/food_dao.dart';
import '../components/logo.dart';

class RandomPage extends StatefulWidget{
  final List<FoodDAO> foods;
  RandomPage({super.key, required this.foods});
  @override
  State<StatefulWidget> createState() => RandomPageState();

}

class RandomPageState extends State<RandomPage> with SingleTickerProviderStateMixin {
  bool isPopupVisible = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late ShakeDetector _detector;
  int index = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 8.0).animate(_animationController);
    _detector = ShakeDetector.waitForStart(
      onPhoneShake: () {
        // Do stuff on phone shake
        Vibration.vibrate(duration: 400);
        setState(() {
          index = (index + 1) % 2; // Toggle between 0 and 1
          _detector.stopListening();
          _animationController.forward();

        });
      },
    );
    _detector.startListening();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int rand = Random().nextInt(widget.foods.length);
    var cards = [FoodCard(widget.foods[rand])];

    // TODO: implement build
    return SafeArea(
        child: (index == 0) ? Column(
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
                ),
              ],
            ):
    BlocProvider<SwiperBloc>(
        create: (context) => SwiperBloc(),
        child:
        AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Container(
              alignment: Alignment.center,
              child: FoodSwiper(
                context: context,
                foodCards: cards,
                like: () {},
                dislike: () {
                  setState(() {
                    index = (index + 1) % 2; // Toggle between 0 and 1
                    _detector.startListening();
                  });
                },
              ),
            );
        }
    )
    ),

    );
  }
}

