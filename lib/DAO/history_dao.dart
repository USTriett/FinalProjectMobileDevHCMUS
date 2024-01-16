class HistoryDAO {
  String? _food_id = '';
  String? _food_name = '';
  String? _food_image = '';
  String? _restaurant_id = '';
  String? _restaurant_name = '';
  String? _restaurant_address = '';
  String? _time = '';

  HistoryDAO([
    this._food_id,
    this._food_name,
    this._food_image,
    this._restaurant_id,
    this._restaurant_name,
    this._restaurant_address,
    this._time,
  ]);

  String? get food_id {
    return _food_id;
  }

  set food_id(String? newFood_id) {
    _food_id = newFood_id;
  }

  String? get food_name {
    return _food_name;
  }

  set food_name(String? newFood_name) {
    _food_name = newFood_name;
  }

  String? get food_image {
    return _food_image;
  }

  set food_image(String? newFood_image) {
    _food_image = newFood_image;
  }

  String? get restaurant_id {
    return _restaurant_id;
  }

  set restaurant_id(String? newRestaurant_id) {
    _restaurant_id = newRestaurant_id;
  }

  String? get restaurant_name {
    return _restaurant_name;
  }

  set restaurant_name(String? newRestaurant_name) {
    _restaurant_name = newRestaurant_name;
  }

  String? get restaurant_address {
    return _restaurant_address;
  }

  set restaurant_address(String? newRestaurant_address) {
    _restaurant_address = newRestaurant_address;
  }

  String? get time {
    return _time;
  }

  set time(String? newTime) {
    _time = newTime;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['food_id'] = _food_id;
    map['food_name'] = _food_name;
    map['food_image'] = _food_image;
    map['restaurant_id'] = _restaurant_id;
    map['restaurant_name'] = _restaurant_name;
    map['restaurant_address'] = _restaurant_address;
    map['time'] = _time;
    return map;
  }

  HistoryDAO.fromMapObject(Map<String, dynamic> map) {
    _food_id = map['food_id'];
    _food_name = map['food_name'];
    _food_image = map['food_image'];
    _restaurant_id = map['restaurant_id'];
    _restaurant_name = map['restaurant_name'];
    _restaurant_address = map['restaurant_address'];
    _time = map['time'];
  }

  static HistoryDAO empty() {
    return HistoryDAO('', '', '', '', '', '', '');
  }
}

// example:
//  {
//     "_food_id": "2",
//     "_food_name": "Cơm rang",
//     "_food_image": "https://i.imgur.com/0y8Ftya.jpg",
//     "_restaurant_id": "2",
//     "_restaurant_name": "Nhà hàng B",
//     "_restaurant_address": "123 Nguyễn Văn B",
//     "_time": "2021-10-10 10:10:10"
//   }