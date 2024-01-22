
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionDAO {
  String _question; // Sử dụng dấu "_" để đặt tên cho thuộc tính riêng tư
  List<String> _options;


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

  factory QuestionDAO.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc){
    final data = doc.data();
    return QuestionDAO(
        question: data?["question"] as String,
        options: [data?['options']['0'] as String, data?['options']['1'] as String]
    );
  }
}