import 'package:flutter/material.dart';
import 'package:next_food/DAO/question_dao.dart';
import 'package:next_food/Data/data_manager.dart';
import 'package:next_food/Themes/theme_constants.dart';

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



class QuestionWidget extends StatefulWidget {
  final QuestionDAO questionDAO;
  final int index;
  const QuestionWidget({Key? key, required this.questionDAO, required this.index}) : super(key: key);

  @override
  QuestionWidgetState createState() => QuestionWidgetState();
}

class QuestionWidgetState extends State<QuestionWidget> {
  String selectedOption = '';
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị câu hỏi
          Text(
            widget.questionDAO.question,
            style: ThemeConstants.textStyleMedium,
          ),
      
          // Hiển thị các nút nhấn cho các options
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.questionDAO.options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = option;
                    widget.questionDAO.answer = selectedOption;
                    DataManager.ans[widget.index] = selectedOption;
                  });
                },
                style: selectedOption == option ? chose : un_chose,
                child: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
