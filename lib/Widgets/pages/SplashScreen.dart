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

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/Splash Screen.png"
            ),

            fit: BoxFit.fill
          ),
          color: Color(0xffffb901),
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