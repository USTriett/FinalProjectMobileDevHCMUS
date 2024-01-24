import 'package:flutter/material.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/color_button.dart';
import 'package:next_food/Widgets/components/question_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Data/data_manager.dart';

Map<String, String> dictionary = {
  "Kiêng": "Healthy",
  "Không kiêng": "Unhealthy",
  "chay": "Vegetable",
  "mặn": "Meaty",
  "nước": "Soup",
  "khô": "Dry",
};

ButtonStyle un_chose = ElevatedButton.styleFrom(
  primary: Colors.white,
  onPrimary: Colors.grey,
  elevation: 5,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side: BorderSide(color: Colors.grey, width: 2),
  ),
);

ButtonStyle chose = ElevatedButton.styleFrom(
  primary: Colors.white,
  onPrimary: ThemeConstants.titleColor,
  elevation: 5,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side: BorderSide(color: ThemeConstants.titleColor, width: 2),
  ),
);

class QuestionDAO {
  String _question; // Sử dụng dấu "_" để đặt tên cho thuộc tính riêng tư
  List<String> _options;
  late String _answer;

  QuestionDAO({required String question, required List<String> options})
      : _question = question,
        _options = options;

  // Getter cho question
  String get question => _question;

  // Setter cho question
  set question(String value) {
    _question = value;
  }

  // Getter cho options
  List<String> get options => _options;

  // Setter cho options
  set options(List<String> value) {
    _options = value;
  }

  factory QuestionDAO.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return QuestionDAO(question: data?["question"] as String, options: [
      data?['options'][0] as String,
      data?['options'][1] as String
    ]);
  }

  // Getter cho question
  String get answer => _answer;

  // Setter cho question
  set answer(String value) {
    _answer = value;
  }

  Map<String, Object?> toJson() {
    return {
      'options': options.join(","),
      'question': question,
    };
  }

  factory QuestionDAO.fromMap(Map<String, Object?> map) {
    return QuestionDAO(
      question: map['question'] as String,
      options: (map['options'] as String).split(','),
    );
  }
}

class ListQuestionDAO {
  List<QuestionDAO> _questions;

  ListQuestionDAO({
    required List<QuestionDAO> questions,
  }) : _questions = questions;

  Future<void> showQuestionsPopup(
      BuildContext context, VoidCallback filterCallback) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _dismissDialog() {
          Navigator.pop(context);
        }

        return AlertDialog(
          title: Text(
            'Questions',
            style: ThemeConstants.textStyleLarge,
          ),
          actions: <Widget>[
            colorButton(context, 'Lọc', () async {
              if (filterCallback != null) {
                filterCallback();
              }
              await DataManager.updateAnswer(_questions);
              _dismissDialog();
            }),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('Bỏ qua')),
          ],
          content: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _questions.length,
                    itemBuilder: (BuildContext context, int index) {
                      QuestionDAO question = _questions[index];
                      return QuestionWidget(questionDAO: question);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String toString() {
    String res = "";
    for (QuestionDAO questionDAO in _questions) {
      String buffer = (questionDAO._answer == null) ? "" : questionDAO._answer;
      res = res + " " + dictionary[buffer]!;
    }
    res = res + " " + "dish";
    return res;
  }
}
