import 'package:next_food/DAO/answer_dao.dart';
import 'package:next_food/DAO/history_dao.dart';

class UserDAO {
  String _id = "";
  String _name = "";
  List<HistoryDAO>? _history;
  List<AnswerDAO>? _answers;

  UserDAO(this._id, this._name, [this._history, this._answers]);

  String get id {
    return _id;
  }

  set id(String newId) {
    _id = newId;
  }

  String get name {
    return _name;
  }

  set name(String newName) {
    _name = newName;
  }

  List<HistoryDAO>? get history {
    return _history;
  }

  set history(List<HistoryDAO>? newHistory) {
    _history = newHistory;
  }

  List<AnswerDAO>? get answers {
    return _answers;
  }

  set answers(List<AnswerDAO>? newAnswers) {
    _answers = newAnswers;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['name'] = _name;
    map['history'] = _history;
    map['answers'] = _answers;
    return map;
  }

  UserDAO.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._history = map['history'];
    this._answers = map['answers'];
  }
}

// example:
  // "_id": "1",
  // "_name": "Nguyễn Văn A",
  // "_history": [
  //   {
  //     "_food_id": "1",
  //     "_food_name": "Cơm chiên",
  //     "_food_image": "https://i.imgur.com/0y8Ftya.jpg",
  //     "_restaurant_id": "1",
  //     "_restaurant_name": "Nhà hàng A",
  //     "_restaurant_address": "123 Nguyễn Văn A",
  //     "_time": "2021-10-10 10:10:10"
  //   },
  //   {
  //     "_food_id": "2",
  //     "_food_name": "Cơm rang",
  //     "_food_image": "https://i.imgur.com/0y8Ftya.jpg",
  //     "_restaurant_id": "2",
  //     "_restaurant_name": "Nhà hàng B",
  //     "_restaurant_address": "123 Nguyễn Văn B",
  //     "_time": "2021-10-10 10:10:10"
  //   },
  // ],
  // "_answers": [
  //   {
  //     "_question_id": "1",
  //     "_question_content": "Bạn ăn chay hay ăn mặn?",
  //     "_answer_id": "1",
  //     "_answer_content": "Chay"
  //   },
  //   {
  //     "_question_id": "1",
  //     "_question_content": "Bạn ăn khô hay ăn nước?",
  //     "_answer_id": "2",
  //     "_answer_content": "Nước"
  //   },
  //  ]