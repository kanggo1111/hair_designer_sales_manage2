import 'package:flutter/material.dart';

late DateTime now;
late int currentYear;
late int currentMonth;

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  @override
  void initState() {
    // TODO: implement initState
    now = DateTime.now();
    currentYear = now.year;
    currentMonth = now.month;
    super.initState();
  }

  void setPrevMonth() {
    if (currentMonth == 1) {
      currentYear--;
      currentMonth = 12;
    } else {
      currentMonth--;
    }
  }

  void setNextMonth() {
    if (currentMonth == 12) {
      currentYear++;
      currentMonth = 1;
    } else {
      currentMonth++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  setPrevMonth();
                });
              },
              child: Icon(
                Icons.arrow_left,
                size: 40,
              )),
          Text(
            '$currentYear. ${currentMonth.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 24),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                setNextMonth();
              });
            },
            child: Icon(
              Icons.arrow_right,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
