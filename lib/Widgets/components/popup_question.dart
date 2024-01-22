import 'package:flutter/material.dart';
import 'package:next_food/DAO/question_dao.dart';

List<QuestionDAO> questions = [
  QuestionDAO(
    question: 'What is the capital of France?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
    answer: '',
  ),
  QuestionDAO(
    question: 'What is the capital of Germany?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
    answer: '',
  ),
    QuestionDAO(
    question: 'What is the capital of France?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
    answer: '',
  ),
  QuestionDAO(
    question: 'What is the capital of Germany?',
    options: ['Paris', 'Berlin', 'London', 'Rome'],
    answer: '',
  ),
  // Add more questions as needed
];

class TestPage extends StatelessWidget {
  bool is_shown = true;

  ListQuestionDAO Lisquestions = ListQuestionDAO(questions: questions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Container(
        child: Center(
          child: ElevatedButton(
            // color: Colors.redAccent,
            // textColor: Colors.white,
            onPressed: () {
              Lisquestions.showQuestionsPopup(context);
            },
            child: Text("PressMe"),
          ),
        ),
      ),
    );
  }
}
