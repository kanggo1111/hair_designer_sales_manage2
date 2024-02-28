import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/model/my_settings.dart';

class SettingsController extends GetxController {
  MySettings _settings = MySettings();
  final FirebaseAuth authentication = FirebaseAuth.instance;
  late final user = authentication.currentUser;

  MySettings get settings => _settings;

  SettingsController(){
    fetchSettings();
  }


  List<String> colorList = ['brown',
    'pink',
    'pinkAccent',
    'red',
    'redAccent',
    'deepOrange',
    'deepOrangeAccent',
    'orange',
    'orangeAccent',
    'amber',
    'amberAccent',
    'yellow',
    'yellowAccent',
    'lime',
    'limeAccent',
    'lightGreen',
    'lightGreenAccent',
    'green',
    'greenAccent',
    'teal',
    'tealAccent',
    'cyan',
    'cyanAccent',
    'lightBlue',
    'lightBlueAccent',
    'blue',
    'blueAccent',
    'indigo',
    'indigoAccent',
    'blueGrey',
    'purple',
    'purpleAccent',
    'deepPurple',
    'deepPurpleAccent',
    'grey',
    'white',
    'black'
  ];
  Map<String, Color> colorMap = {
    'brown': Colors.brown,
    'pink': Colors.pink,
    'pinkAccent': Colors.pinkAccent,
    'red': Colors.red,
    'redAccent': Colors.redAccent,
    'deepOrange': Colors.deepOrange,
    'deepOrangeAccent': Colors.deepOrangeAccent,
    'orange': Colors.orange,
    'orangeAccent': Colors.orangeAccent,
    'amber': Colors.amber,
    'amberAccent': Colors.amberAccent,
    'yellow': Colors.yellow,
    'yellowAccent': Colors.yellowAccent,
    'lime': Colors.lime,
    'limeAccent': Colors.limeAccent,
    'lightGreen': Colors.lightGreen,
    'lightGreenAccent': Colors.lightGreenAccent,
    'green': Colors.green,
    'greenAccent': Colors.greenAccent,
    'teal': Colors.teal,
    'tealAccent': Colors.tealAccent,
    'cyan': Colors.cyan,
    'cyanAccent': Colors.cyanAccent,
    'lightBlue': Colors.lightBlue,
    'lightBlueAccent': Colors.lightBlueAccent,
    'blue': Colors.blue,
    'blueAccent': Colors.blueAccent,
    'indigo': Colors.indigo,
    'indigoAccent': Colors.indigoAccent,
    'blueGrey': Colors.blueGrey,
    'purple': Colors.purple,
    'purpleAccent': Colors.purpleAccent,
    'deepPurple': Colors.deepPurple,
    'deepPurpleAccent': Colors.deepPurpleAccent,
    'grey': Colors.grey,
    'white': Colors.white,
    'black': Colors.black,
  };

  Color getColor(String colorName){
    return colorMap[colorName]!;
  }

  void fetchSettings() async {
    try {
      DocumentSnapshot<dynamic> snapshots =  await FirebaseFirestore.instance
          .collection('item')
          .doc(user!.uid)
          .collection('settings')
          .doc(user!.uid)
          .get();

      if(snapshots != null){
        _settings = MySettings.fromJson(snapshots);
      }
    } on Exception catch (e) {
      // TODO
    }

    update();
  }

  void writeSettings(Map<String, dynamic> newSetting) async {
    Map<String, dynamic> jsonSettings= _settings.toJson();

    for(String key in newSetting.keys){
      jsonSettings[key] = newSetting[key];
    }
    _settings = MySettings.fromJson(jsonSettings);

    await FirebaseFirestore.instance
        .collection('item')
        .doc(user!.uid)
        .collection('settings')
        .doc(user!.uid)
        .set(_settings.toJson());

    update();
  }
}
