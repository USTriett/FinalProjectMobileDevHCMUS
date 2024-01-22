import 'package:flutter/material.dart';
import 'package:next_food/Themes/theme_constants.dart';
import 'package:next_food/Widgets/components/color_button.dart';
import 'package:next_food/Widgets/components/question_item.dart';

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
  String _answer;

  QuestionDAO(
      {required String question,
      required List<String> options,
      required String answer})
      : _question = question,
        _options = options,
        _answer = answer;

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

  // Getter cho question
  String get answer => _answer;

  // Setter cho question
  set answer(String value) {
    _answer = value;
  } 
}

class ListQuestionDAO {
  List<QuestionDAO> _questions;

  ListQuestionDAO({
    required List<QuestionDAO> questions,
  }) : _questions = questions;

  Future<void> showQuestionsPopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        _dismissDialog() {
          Navigator.pop(context);
        }

        return AlertDialog(
          title: Text('Questions', style: ThemeConstants.textStyleLarge,),
          actions: <Widget>[
            colorButton(context, 'Lọc', () {
              print(printAnswer());
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

  String printAnswer(){
    String res = "";
    for(QuestionDAO questionDAO in _questions){
      res = res + " " + questionDAO._answer;
    }
    return res;
  }
}
