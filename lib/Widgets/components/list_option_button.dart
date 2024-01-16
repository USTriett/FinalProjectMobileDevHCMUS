
import 'package:flutter/material.dart';
import 'package:next_food/DAO/question_dao.dart';

class ListOption extends StatefulWidget {
  final QuestionDAO questionDAO;

  ListOption({required this.questionDAO});

  @override
  _ListOptionPageState createState() => _ListOptionPageState();
}

class _ListOptionPageState extends State<ListOption> {
  int selectedOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Page'),
      ),
      body: Column(
        children: [
          // Hàng 1: Hiển thị câu hỏi
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              widget.questionDAO.question,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          // Hàng 2: Hiển thị danh sách các option
          Container(
            height: 50.0,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.questionDAO.options.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    child: ElevatedButton(
                      
                      onPressed: () {
                        setState(() {
                          selectedOptionIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.0),
                        
                        padding: EdgeInsets.all(16.0),
                        side: BorderSide(
                          color: selectedOptionIndex == index ? Colors.yellow : Colors.grey,
                        ),
                      ),
                      child: Text(
                        widget.questionDAO.options[index],
                        style: TextStyle(
                          color: selectedOptionIndex == index ? Colors.yellow : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}