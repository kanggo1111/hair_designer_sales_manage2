/// color : "indigo"

class MySettings {
  MySettings({
      String? color = 'indigoAccent',}){
    _color = color;
}

  MySettings.fromJson(dynamic json) {
    _color = json['color'];

    // TODO: check has key
    // if ((json as Map<String, dynamic>).containsKey('color') == true) {
    //   _color = json['color'];
    // }
  }
  String? _color;

  String? get color => _color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['color'] = _color;
    return map;
  }

}