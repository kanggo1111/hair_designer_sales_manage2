import 'dart:convert';

import 'package:intl/intl.dart';
/// id : 20240218124905520
/// date : "2024-02-03"
/// type : "지명"
/// count : 2
/// price : 56000

Item itemFromJson(String str) => Item.fromJson(json.decode(str));
String itemToJson(Item data) => json.encode(data.toJson());
class Item {
  Item({
      int? id, 
      String? date, 
      String? type, 
      int? count, 
      int? price,}){
    String newId = DateFormat('yMMddHHmmssS').format(DateTime.now());
    newId = newId.substring(0, newId.length-2);
    _id = int.parse(newId);
    _date = date;
    _type = type;
    _count = count;
    _price = price;
}

  Item.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _type = json['type'];
    _count = json['count'];
    _price = json['price'];
  }
  int? _id;
  String? _date;
  String? _type;
  int? _count;
  int? _price;

  int? get id => _id;
  String? get date => _date;
  String? get type => _type;
  int? get count => _count;
  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['type'] = _type;
    map['count'] = _count;
    map['price'] = _price;
    return map;
  }

}

/*
/// id : "20240218124905520"
/// user : "test@test.com"
/// date : "2024-02-03"
/// type : "지명"
/// count : 2
/// price : 56000

class TempModel {
  TempModel({
    String? id,
    String? user,
    String? date,
    String? type,
    int? count,
    int? price,}){
    _id = id;
    _user = user;
    _date = date;
    _type = type;
    _count = count;
    _price = price;
  }

  TempModel.fromJson(dynamic json) {
    _id = json['id'];
    _user = json['user'];
    _date = json['date'];
    _type = json['type'];
    _count = json['count'];
    _price = json['price'];
  }
  String? _id;
  String? _user;
  String? _date;
  String? _type;
  int? _count;
  int? _price;

  String? get id => _id;
  String? get user => _user;
  String? get date => _date;
  String? get type => _type;
  int? get count => _count;
  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user'] = _user;
    map['date'] = _date;
    map['type'] = _type;
    map['count'] = _count;
    map['price'] = _price;
    return map;
  }

}
 */