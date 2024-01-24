import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDAO {
  String _categoryID;
  String _categoryName;
  String _imageURL;
  List<String> _listFoodId;

  CategoryDAO({
    required categoryID,
    required categoryName,
    required imageURL,
    required listFoodId,
  })  : _categoryID = categoryID,
        _categoryName = categoryName,
        _imageURL = imageURL,
        _listFoodId = listFoodId;

  String get categoryID => _categoryID;

  set categoryID(String value) {
    _categoryID = value;
  }

  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
  }

  String get imageURL => _imageURL;

  set imageURL(String value) {
    _imageURL = value;
  }

  List<String> get listFoodId => _listFoodId;

  set listFoodId(List<String> value) {
    _listFoodId = value;
  }

  factory CategoryDAO.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return CategoryDAO(
      categoryID: doc.id,
      categoryName: data?['categoryName'] as String,
      imageURL: data?['imageURL'] as String,
      listFoodId: [
        for (var i in data?['listFoodId']) i.toString(),
      ],
    );
  }

  Map<String, dynamic> toJson() {
    var json = {
      'categoryID': categoryID,
      'categoryName': categoryName,
      'imageURL': imageURL,
      'listFoodId': listFoodId.join(",")
    };
    // print("##### json: $json");
    return json;
  }

  factory CategoryDAO.fromMap(Map<String, Object?> map) {
    return CategoryDAO(
      categoryID: map['categoryID'] as String,
      categoryName: map['categoryName'] as String,
      imageURL: map['imageURL'] as String,
      listFoodId: (map['listFoodId'] as String).split(','),
    );
  }
}
