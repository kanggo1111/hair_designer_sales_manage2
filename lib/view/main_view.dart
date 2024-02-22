import 'package:flutter/material.dart';
import 'package:hair_designer_sales_manage2/devel.dart';
import 'package:hair_designer_sales_manage2/view/calendar.dart';

Color appBarContentColor = Colors.white;

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Main View', style: TextStyle(color: appBarContentColor),),
        actions: [
          IconButton(onPressed: () {
            showSnackBar('아직 지원하지 않는 기능입니다.'); // TODO
          }, icon: Icon(Icons.calendar_month, color: appBarContentColor,)),
          IconButton(onPressed: () {
            showSnackBar('아직 지원하지 않는 기능입니다.'); // TODO
          }, icon: Icon(Icons.bar_chart_sharp, color: appBarContentColor)),
          IconButton(onPressed: () {
            showSnackBar('아직 지원하지 않는 기능입니다.'); // TODO

          }, icon: Icon(Icons.settings, color: appBarContentColor)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Calendar(),
    );
  }
}
