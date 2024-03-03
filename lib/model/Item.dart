import 'dart:convert';

/// id : 20240218124905520
/// date : "2024-02-03"
/// type : "지명"
/// count : 2
/// price : 56000

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    String? id,
    int? date,
    String? type,
    int? count,
    int? price,
  }) {
    _id = id;
    _date = date;
    _type = type;
    _count = count;
    _price = price;
  }

  Item.fromJson(dynamic json) {
    _id = json.id;
    _date = json['date'];
    _type = json['type'];
    _count = json['count'];
    _price = json['price'];
  }

  String? _id;
  int? _date;
  String? _type;
  int? _count;
  int? _price;

  String? get id => _id;

  int? get date => _date;

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
