class AnswerDAO {
  String question_id = '';
  String answer_id = '';
  String answer_content = '';
  String question_content = '';

  AnswerDAO(
    this.question_id,
    this.answer_id,
    this.answer_content,
    this.question_content,
  );

  String get questionId {
    return question_id;
  }

  set questionId(String newQuestionId) {
    question_id = newQuestionId;
  }

  String get answerId {
    return answer_id;
  }

  set answerId(String newAnswerId) {
    answer_id = newAnswerId;
  }

  String get answerContent {
    return answer_content;
  }

  set answerContent(String newAnswerContent) {
    answer_content = newAnswerContent;
  }

  String get questionContent {
    return question_content;
  }

  set questionContent(String newQuestionContent) {
    question_content = newQuestionContent;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['question_id'] = question_id;
    map['answer_id'] = answer_id;
    map['answer_content'] = answer_content;
    map['question_content'] = question_content;
    return map;
  }

  AnswerDAO.fromMapObject(Map<String, dynamic> map) {
    this.question_id = map['question_id'];
    this.answer_id = map['answer_id'];
    this.answer_content = map['answer_content'];
    this.question_content = map['question_content'];
  }
}

// example:
//  {
//     "_question_id": "1",
//     "_question_content": "Bạn ăn chay hay ăn mặn?",
//     "_answer_id": "1",
//     "_answer_content": "Chay"
//   },