/// color : "indigo"

class MySettings {
  MySettings({
      String? color,}){
    _color = color;
}

  MySettings.fromJson(dynamic json) {
    _color = json['color'];
  }
  String? _color;

  String? get color => _color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['color'] = _color;
    return map;
  }

}