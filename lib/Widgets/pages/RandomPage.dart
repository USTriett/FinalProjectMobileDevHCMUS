import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/food_card.dart';
import 'package:next_food/Widgets/components/foods_swiper.dart';
import 'package:next_food/Widgets/pages/MapPage.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

import '../../Bloc/swiper_bloc.dart';
import '../../DAO/food_dao.dart';
import '../../Values/constants.dart';
import '../components/logo.dart';

class RandomPage extends StatefulWidget{
  final List<FoodDAO> foods;
  RandomPage({required this.foods}): super(key:WidgetKey.randomPageKey);
  @override
  State<StatefulWidget> createState() => RandomPageState();

}

class RandomPageState extends State<RandomPage> with SingleTickerProviderStateMixin {
  bool isPopupVisible = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late ShakeDetector _detector;
  int index = 0;
  double shakeThreshold = 20;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    // widget._streamSubscription = accelerometerEvents.listen(
    //       (AccelerometerEvent event) {
    //     // print('shake $event');
    //         if (event.x.abs() > shakeThreshold ||
    //             event.y.abs() > shakeThreshold
    //             ) {
    //           // Device is being shaken, perform desired actions here
    //               Vibration.vibrate(duration: 200);
    //               setState(() {
    //                 index = (index + 1)%2;
    //                 // widget._streamSubscription.pause();
    //               });
    //           // print('Device shaken!');
    //         }
    //   },
    //   onError: (error) {
    //     print("Error $e");
    //   },
    //   cancelOnError: true,
    // );
    _animation = Tween<double>(begin: 0.0, end: 1).animate(_animationController);
    // _detector = ShakeDetector.waitForStart(
    //   shakeThresholdGravity: 3.0,
    //   onPhoneShake: () {
    //     // Do stuff on phone shake
    //     Vibration.vibrate(duration: 400);
    //     setState(() {
    //       index = (index + 1) % 2; // Toggle between 0 and 1
    //       _detector.stopListening();
    //       // _animationController.forward();
    //
    //     });
    //   },
    // );
    // _detector.startListening();
    _animationController.forward();
  }

  @override
  void dispose() {

    _animationController.dispose();
    super.dispose();
  }

  void setShakeAvailable(bool available){
    if(available)
      _detector.startListening();
    else
      _detector.stopListening();

  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    int rand = Random().nextInt(widget.foods.length);
    FoodDAO food = widget.foods[rand];
    var cards = [FoodCard(food)];
    if(index == 0){
      _detector = ShakeDetector.waitForStart(
        shakeThresholdGravity: 4.0,
        onPhoneShake: () {
          // Do stuff on phone shake
          Vibration.vibrate(duration: 400);
          setState(() {
            index = (index + 1) % 2; // Toggle between 0 and 1
            _detector.stopListening();
            // _animationController.forward();

          });
        },
      );
      _detector.startListening();
    }
    else{
      _detector.stopListening();
    }
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

    FadeTransition(
      opacity: _animation,
      child: BlocProvider<SwiperBloc>(
          create: (context) => SwiperBloc(),
          child:
          Container(
                alignment: Alignment.center,
                child: FoodSwiper(
                  context: context,
                  foodCards: cards,
                  like: () {

                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> MapPage(food: food))
                    );
                    setState(() {
                      // print(cards[0])
                      index = (index + 1) % 2; // Toggle between 0 and 1
                      // widget._streamSubscription.resume();
                    });
                  },
                  dislike: () {
                    setState(() {
                      // print(cards[0])
                      index = (index + 1) % 2; // Toggle between 0 and 1
                      // widget._streamSubscription.resume();
                    });
                  },
                ),
              )

      ),
    ),

    );
  }
}

