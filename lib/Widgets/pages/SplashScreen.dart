import 'package:flutter/material.dart';
import 'package:next_food/Widgets/pages/NavBar.dart';

import '../../Data/data_manager.dart';
import '../../Data/sqlite_data.dart';
import '../../Values/constants.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation hoàn thành, chuyển đến màn hình chính
        _navigateToHome();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Splash Screen.png"),
              fit: BoxFit.fill,
            ),
            color: Color(0xffffb901),
          ),
          // child: FadeTransition(
          //   opacity: _animation,
          //   child: const FlutterLogo(size: 200), // Thay thế với widget bạn muốn áp dụng animation
          // ),
        ),
      ),
    );
  }

  void _navigateToHome() async{
    final loadDataDuration = SqliteData.loadAllData(); // Bắt đầu tải dữ liệu

    // Delay for a minimum duration
    final minimumDuration = Future.delayed(const Duration(seconds: 2)); // Thời gian tối thiểu
    await Future.wait([loadDataDuration, minimumDuration]);
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=> NavBarComponent.getInstance(0))
    );
  }
}