import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color calendarBorderColor = Colors.grey[400]!;
double calendarBorderWidth = 0.5;

class Calendar extends StatelessWidget {
  Calendar({super.key});


  var now = DateTime.now();

  int getStartingDay(DateTime now) {
    switch (DateFormat('E')
        .format(DateTime(now.year, now.month, 1))
        .toUpperCase()) {
      case 'SUN':
        return 0;
      case 'MON':
        return 1;
      case 'TUE':
        return 2;
      case 'WED':
        return 3;
      case 'THU':
        return 4;
      case 'FRI':
        return 5;
      case 'SAT':
        return 6;
      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    int startingDay = getStartingDay(now);

    return Column(
      children: [
        Text(
          DateFormat('y-MM-dd').format(now),
          style: TextStyle(fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  color: calendarBorderColor, width: calendarBorderWidth)),
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, childAspectRatio: 0.8),
              itemCount: 42,
              itemBuilder: (context, index) {
                String day = DateFormat('MM-dd').format(DateTime(
                    now.year, now.month, 1 - startingDay + index));
                return DayContainer(now, day, index);
              }),
        ),
      ],
    );
  }
}

Widget DayContainer(DateTime now, String day, int index) {
  String dayText = '';
  Color dayColor = Colors.black87;
  Color priceColor = Colors.blue[300]!;
  bool needShadow = false;

  if(index % 7 == 0){
    dayColor = Colors.red;
  }else if(index % 7 == 6){
    dayColor = Colors.blue;
  }

  if(int.parse(day.substring(0, 2)) != now.month){
    if(day.substring(0, 1) == '0'){
      day = day.substring(1, day.length);
    }
    day = day.replaceAll('-0', '.').replaceAll('-', '.');
    dayText = day;
    needShadow = true;
    dayColor = dayColor.withOpacity(0.5);
    priceColor = priceColor.withOpacity(0.5);
  }else{
    dayText = int.parse(day.substring(3, 5)).toString();
  }

  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: calendarBorderColor,
                width: calendarBorderWidth)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dayText, style: TextStyle(color: dayColor),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('2,000,000', style: TextStyle(fontSize: 10, color: priceColor),),
              ],
            ),
          ],
        ),
      ),
      if(needShadow) Container(color: Colors.grey.withOpacity(0.15))
    ],
  );
}