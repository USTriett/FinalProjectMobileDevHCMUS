import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:next_food/Bloc/States/swiper_states/swiper_states.dart';
import 'package:next_food/Bloc/navbar_bloc.dart';
import 'package:next_food/Bloc/swiper_bloc.dart';
import 'package:next_food/DAO/food_dao.dart';
import 'package:next_food/DAO/question_dao.dart';
import 'package:next_food/Data/data_manager.dart';
import 'package:next_food/Data/sqlite_data.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Themes/theme_manager.dart';
import 'package:next_food/Widgets/components/food_card.dart';
import 'package:next_food/Widgets/components/foods_swiper.dart';
import 'package:next_food/Widgets/components/popup_question.dart';
import 'package:next_food/Widgets/components/question_item.dart';
import 'package:next_food/Widgets/pages/HistoryPage.dart';

import 'package:next_food/Widgets/pages/SplashScreen.dart';

import 'package:next_food/Widgets/pages/MapPage.dart';

import 'package:next_food/Widgets/pages/VerifyEmailPage.dart';

import 'package:next_food/Widgets/components/logo.dart';
import 'package:next_food/Widgets/pages/RandomPage.dart';
import 'package:next_food/Widgets/pages/SettingPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import 'Values/constants.dart';
import 'Widgets/pages/HomePage.dart';
import 'Widgets/pages/NavBar.dart';
import 'Widgets/pages/SignUpPage.dart';
import 'Widgets/pages/SignInPage.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:next_food/Service/auth_service.dart';


Future<void> deleteDatabaseFile() async {
  // Lấy thư mục lưu trữ ứng dụng
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDir.path, 'NextFood.db');

  // Xóa cơ sở dữ liệu SQLite
  await deleteDatabase(dbPath);
}

void main() async {
  // // All widgets need to be initialized before they can be used.

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase.
  await Firebase.initializeApp();
  await deleteDatabaseFile();

  await SqliteData.insertAllData();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Widget currentPage = const SignInPage();
  AuthClass authClass = AuthClass();
  FirebaseAuth auth = FirebaseAuth.instance;

  void checkLogin() async {
    String? token = await authClass.getToken();
    bool isVerified = auth.currentUser!.emailVerified;

    if (token != null) {
      print('token $token');
      setState(() {
        authClass.test();
        currentPage = (isVerified ? const SplashScreen() : const VerifyEmailPage());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: currentPage,

    );
}

  // @override
  // Widget build(BuildContext context){
  //   return MaterialApp(
  //     home: Scaffold(
  //       backgroundColor: Colors.blue,
  //       appBar: AppBar(
  //         title: Text('Curved Nav Bar', textDirection: TextDirection.rtl,),
  //         elevation: 0,
  //         centerTitle: true,
  //       ),
  //       body: Container(),
  //     ),
  //   );
  // }
/*=======
        home: Scaffold(
      body: TestPage(),
    ));
  }
>>>>>>> Eric*/
}




