import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key});

  Color calendarBorderColor = Colors.grey[400]!;
  double calendarBorderWidth = 0.5;

  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: calendarBorderColor, width: calendarBorderWidth)),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 0.8),
        itemCount: 42,
        itemBuilder: (context, index) => Container(decoration: BoxDecoration(border: Border.all(color: calendarBorderColor, width: calendarBorderWidth)),
        child: Text('11'),)
      ),
    );
  }
}
