class QuestionDAO {
  String? _question_id;
  String? _question_content;
  List<Map<String, dynamic>>? _answers;

  QuestionDAO(this._question_id, this._question_content, [this._answers]);

  String? get question_id {
    return _question_id;
  }

  set question_id(String? newQuestion_id) {
    _question_id = newQuestion_id;
  }

  String? get question_content {
    return _question_content;
  }

  set question_content(String? newQuestion_content) {
    _question_content = newQuestion_content;
  }

  List<Map<String, dynamic>>? get answers {
    return _answers;
  }

  set answers(List<Map<String, dynamic>>? newAnswers) {
    _answers = newAnswers;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['question_id'] = _question_id;
    map['question_content'] = _question_content;
    map['answers'] = _answers;
    return map;
  }

  QuestionDAO.fromMapObject(Map<String, dynamic> map) {
    this._question_id = map['question_id'];
    this._question_content = map['question_content'];
    this._answers = map['answers'];
  }
}

// example:
// "question_id": "1",
// "question_content": "Bạn ăn chay hay ăn mặn?",
// "answers": [
//   {
//     "answer_id": "1",
//     "answer_content": "Chay",
//   },
//   {
//     "answer_id": "2",
//     "answer_content": "Mặn"
//   },
  //  ]