import 'dart:ffi';

class FoodDAO {
  String _name;
  List<bool> _types;
  String _imgURL;
  int _matched_nums;
  String _script;
  //vidu
  FoodDAO(
      this._name, this._types, this._imgURL, this._matched_nums, this._script);
  String get name {
    return _name;
  }

  set name(String newName) {
    _name = newName;
  }

  String get script {
    return _script;
  }

  set script(String script) {
    _script = script;
  }

  List<bool> get types {
    return _types;
  }

  set types(List<bool> newTypes) {
    _types = newTypes;
  }

  String get imgURL {
    return _imgURL;
  }

  set imgURL(String newImgURL) {
    _imgURL = newImgURL;
  }

  int get matchedNums {
    return _matched_nums;
  }

  set matchedNums(int newMatchedNums) {
    _matched_nums = newMatchedNums;
  }
}
