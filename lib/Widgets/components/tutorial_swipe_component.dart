import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwipeTutorialComponent extends StatefulWidget {
  double height = 100;
  double width = 100;
  SwipeTutorialComponent({Key? key, required double height, required double width}) {
    this.height = height;
    this.width = width;
  }

  @override
  State<SwipeTutorialComponent> createState() => _SwipeTutorialComponentState();
}

class _SwipeTutorialComponentState extends State<SwipeTutorialComponent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1700), () {
      setState(() {
        isVisible = !isVisible;
        _animationController.forward();
      });
    });
    return AnimatedOpacity(
      opacity: isVisible ? _opacityAnimation.value : 0,
      duration: Duration(milliseconds: 500),
      child: Container(
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              "assets/swipe-left-svgrepo-com.svg",
              height: widget.height,
              width: widget.width,
              color: Colors.amber[700],
            ),
            SvgPicture.asset(
              "assets/swipe-right-svgrepo-com.svg",
              height: widget.height,
              width: widget.width,
              color: Colors.amber[700],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}