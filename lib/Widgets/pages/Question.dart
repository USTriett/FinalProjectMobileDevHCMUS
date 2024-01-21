


import 'package:flutter/material.dart';
import 'package:next_food/DAO/question_dao.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/list_option_button.dart';
import 'package:next_food/Widgets/components/logo.dart';
import 'package:next_food/Widgets/pages/HomePage.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppLogoWidget(),
          GestureDetector(
            onTap: () {
              // Xử lý khi người dùng nhấn vào "Bỏ qua"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              // Thêm mã chuyển trang tại đây
            },
            child: Container(
              padding: EdgeInsets.only(top: 20.0, right: MediaQuery.of(context).size.width/10),
              child: Text(
                'Bỏ qua',
                style: ThemeConstants.textStyleLarge,
              ),
            ),
          ),
          ListOption(
            questionDAO: QuestionDAO(
              question: 'Đâu là thủ đô của Việt Nam?',
              options: ['Hà Nội', 'Hồ Chí Minh', 'Đà Nẵng', 'Huế'],
            ),
      )
      ]),
    );
  }
}


