import 'package:flutter/material.dart';
import 'package:next_food/DAO/question_dao.dart';
import 'package:next_food/Data/data_manager.dart';

import '../../DAO/history_dao.dart';

List<QuestionDAO> questions = [
  QuestionDAO(
    question: 'What is the capital of France?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
  ),
  QuestionDAO(
    question: 'What is the capital of Germany?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
  ),
  QuestionDAO(
    question: 'What is the capital of France?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
  ),
  QuestionDAO(
    question: 'What is the capital of Germany?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
  ),
  // Add more questions as needed
];

HistoryDAO history = HistoryDAO(
  '0D4uBRaLjXoL9E9mSduu',
  '"https://cdn.tgdd.vn/2021/02/content/3-800x450-6.jpg"',
  "Mì quảng",
  'restaurant_address',
  'restaurant_id',
  'restaurant_name',
  DateTime.now(),
);

class TestPage extends StatelessWidget {
  bool is_shown = true;
  final List<QuestionDAO> questions;
  TestPage({required this.questions});

  @override
  Widget build(BuildContext context) {
    ListQuestionDAO Lisquestions = ListQuestionDAO(questions: questions);

    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Container(
        child: Center(
          child: ElevatedButton(
            // color: Colors.redAccent,
            // textColor: Colors.white,
            onPressed: () {
              // Lisquestions.showQuestionsPopup(context);
              // print("test api");
              DataManager.addHistory(history);
            },
            child: Text("PressMe"),
          ),
        ),
      ),
    );
  }
}
