import 'package:flutter/material.dart';
import 'package:hair_designer_sales_manage2/view/calendar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
      ),
      body: Calendar(),
    );
  }
}
