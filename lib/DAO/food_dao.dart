import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodDAO{
  String _name;
  List<bool> _types;
  String _imgURL;
  int _matched_nums;
  String _script;
  String id = "";
  //vidu
  FoodDAO(this._name, this._types, this._imgURL, this._matched_nums, this._script);
  FoodDAO.fromId(this.id, this._name, this._types, this._imgURL, this._matched_nums, this._script);

  String get name {
    return _name;
  }

  factory FoodDAO.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc){
    final data = doc.data();
    if(data == null)
      print("food null");
    else
    {
      print("food id: ${doc.id}");
    }
    return FoodDAO.fromId(doc.id, data?['name'], [], data?['image'], data?['match_count'], data?['description']);
  }
  set name(String newName) {
    _name = newName;
  }

  String get script{
    return _script;
  }

  set script(String script){
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': this.imgURL,
      'description': script,
      'name':name,
      'match_count': matchedNums,
    };
  }

  factory FoodDAO.fromMap(Map<String, Object?> map) {
    final String id = map['id'] as String;
    final String name = map['name'] as String;
    final String imgURL = map['image'] as String;
    final int matchedNums = map['match_count'] as int;
    final String script = map['description'] as String;

    return FoodDAO.fromId(id, name, [], imgURL, matchedNums, script);
  }


  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  bool operator ==(other) {
    return other is FoodDAO &&
        id == other.id;
  }
}