import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/month_item_controller.dart';
import 'package:hair_designer_sales_manage2/view/main_view.dart';
import 'package:hair_designer_sales_manage2/view/one_day_view.dart';
import 'package:intl/intl.dart';

Color calendarBorderColor = Colors.grey[400]!;
double calendarBorderWidth = 0.5;
late Color calendarTodayBorderColor;
double calendarTodayBorderWidth = 3;

late DateTime now;
late int currentYear;
late int currentMonth;

class Calendar extends StatefulWidget {
  Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final MonthItemController monthItemController =
      Get.put(MonthItemController());

  @override
  void initState() {
    // TODO: implement initState
    now = DateTime.now();
    currentYear = now.year;
    currentMonth = now.month;
    monthItemController.date = int.parse(
        DateFormat('yMMdd').format(DateTime(currentYear, currentMonth, 1)));
    monthItemController.fetchMonthItem();
    super.initState();
  }

  void setPrevMonth() {
    if (currentMonth == 1) {
      currentYear--;
      currentMonth = 12;
    } else {
      currentMonth--;
    }
    monthItemController.date = int.parse(
        DateFormat('yMMdd').format(DateTime(currentYear, currentMonth, 1)));
    monthItemController.fetchMonthItem();
  }

  void setNextMonth() {
    if (currentMonth == 12) {
      currentYear++;
      currentMonth = 1;
    } else {
      currentMonth++;
    }
    monthItemController.date = int.parse(
        DateFormat('yMMdd').format(DateTime(currentYear, currentMonth, 1)));
    monthItemController.fetchMonthItem();
  }

  @override
  Widget build(BuildContext context) {
    calendarTodayBorderColor = Theme.of(context).colorScheme.primary;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                // TODO:
                GetBuilder<MonthItemController>(
                    builder: (_) => Text(
                          NumberFormat('###,###,###,###')
                              .format(monthItemController.getMonthPrice()),
                          style: TextStyle(fontSize: 18),
                        )),
              ],
            ),
          ),
          CalendarTable(),
        ],
      ),
    );
  }
}

/********** Function **********/

int getStartingDay(int year, int month) {
  switch (DateFormat('E').format(DateTime(year, month, 1)).toUpperCase()) {
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

/********** Widget **********/

Widget CalendarTable() {
  int startingDay = getStartingDay(currentYear, currentMonth);

  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border:
            Border.all(color: calendarBorderColor, width: calendarBorderWidth)),
    child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, childAspectRatio: 0.8),
        itemCount: 42,
        itemBuilder: (context, index) {
          String day = DateFormat('y-MM-dd').format(
              DateTime(currentYear, currentMonth, 1 - startingDay + index));
          return DayContainer(day, index);
        }),
  );
}

Widget DayContainer(String day, int index) {
  String dayText = '';
  Color dayColor = Colors.black87;
  Color priceColor = Colors.blue[300]!;
  bool needShadow = false;
  bool needTodayBorder = false;

  if (index % 7 == 0) {
    dayColor = Colors.red;
  } else if (index % 7 == 6) {
    dayColor = Colors.blue;
  }

  if (day == DateFormat('y-MM-dd').format(now)) {
    needTodayBorder = true;
  }

  dayText = day.substring(5, day.length);
  if (int.parse(dayText.substring(0, 2)) != currentMonth) {
    if (dayText.substring(0, 1) == '0') {
      dayText = dayText.substring(1, dayText.length);
    }
    dayText = dayText.replaceAll('-0', '.').replaceAll('-', '.');
    dayColor = dayColor.withOpacity(0.5);
    priceColor = priceColor.withOpacity(0.5);

    needShadow = true;
  } else {
    dayText = int.parse(dayText.substring(3, 5)).toString();
  }

  return GestureDetector(
    onTap: () {
      Get.toNamed(MainView.routeOneDayView, arguments: day, id: 1);
    },
    child: Stack(
      children: [
        Container(
          padding: needTodayBorder ? null : EdgeInsets.all(3),
          decoration: BoxDecoration(
              border: Border.all(
                  color: needTodayBorder
                      ? calendarTodayBorderColor
                      : calendarBorderColor,
                  width: needTodayBorder
                      ? calendarTodayBorderWidth
                      : calendarBorderWidth)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dayText,
                style: TextStyle(color: dayColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GetBuilder<MonthItemController>(builder: (_) {
                    int dayPrice = Get.find<MonthItemController>().getDayPrice(int.parse(day.substring(5, day.length).replaceAll('-', '')));
                    return Text(
                        dayPrice == 0 ?
                            '' :
                      NumberFormat('###,###,###,###')
                          .format(dayPrice),
                      // Get.find<MonthItemController>().date.toString(),
                      style: TextStyle(fontSize: 10, color: priceColor),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        if (needShadow) Container(color: Colors.grey.withOpacity(0.15)),
      ],
    ),
  );
}
