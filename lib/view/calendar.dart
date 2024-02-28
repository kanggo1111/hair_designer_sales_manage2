import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/month_item_controller.dart';
import 'package:hair_designer_sales_manage2/view/main_view.dart';
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
    refreshCalendar();
    super.initState();
  }

  void setPrevMonth() {
    if (currentMonth == 1) {
      currentYear--;
      currentMonth = 12;
    } else {
      currentMonth--;
    }
    refreshCalendar();
  }

  void setNextMonth() {
    if (currentMonth == 12) {
      currentYear++;
      currentMonth = 1;
    } else {
      currentMonth++;
    }
    refreshCalendar();
  }

  void refreshCalendar(){
    monthItemController.date = int.parse(
        DateFormat('yMMdd').format(DateTime(currentYear, currentMonth, 1)));
    monthItemController.fetchMonthItem();
  }

  @override
  Widget build(BuildContext context) {
    calendarTodayBorderColor = Theme.of(context).colorScheme.primary;

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
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
                SizedBox(height: 10,),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  height: 0,
                  thickness: 3,
                ),
                SummaryTable(context),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  height: 0,
                  thickness: 3,
                ),
              ],
            ),
          ),
          CalendarTable(context),
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

Widget SummaryTable(BuildContext context){
  MonthItemController monthItemController = Get.find<MonthItemController>();
  double titleFontSize = 14;
  double valueFontSize = 16;

  return GetBuilder<MonthItemController>(
    builder: (_) {
      return Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20,),
            Column(children: [
              Text('지명', style: TextStyle(fontSize: titleFontSize),),
              SizedBox(height: 5,),
              Text(monthItemController.getTypeCount('지명').toString(), style: TextStyle(fontSize: valueFontSize)),
            ]),
            SizedBox(width: 10,),
            Column(children: [
              Text('신규', style: TextStyle(fontSize: titleFontSize)),
              SizedBox(height: 5,),
              Text(monthItemController.getTypeCount('신규').toString(), style: TextStyle(fontSize: valueFontSize)),
            ]),
            SizedBox(width: 10,),
            Column(children: [
              Text('총객수', style: TextStyle(fontSize: titleFontSize)),
              SizedBox(height: 5,),
              Text(monthItemController.getTotalCount().toString(), style: TextStyle(fontSize: valueFontSize)),
            ]),
            SizedBox(width: 10,),
            Column(children: [
              Text('월매출', style: TextStyle(fontSize: titleFontSize)),
              SizedBox(height: 5,),
              Text(NumberFormat('###,###,###,###').format(monthItemController.getTotalPrice()), style: TextStyle(fontSize: valueFontSize)),
            ]),
            SizedBox(width: 20,),
          ],
        ),
      );
    }
  );
}

Widget CalendarTable(BuildContext context) {
  int startingDay = getStartingDay(currentYear, currentMonth);

  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).colorScheme.secondary, width: calendarBorderWidth)),
    child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, childAspectRatio: 0.8),
        itemCount: 42,
        itemBuilder: (context, index) {
          String day = DateFormat('y-MM-dd').format(
              DateTime(currentYear, currentMonth, 1 - startingDay + index));
          return DayContainer(context, day, index);
        }),
  );
}

Widget DayContainer(BuildContext context, String day, int index) {
  String dayText = '';
  Color dayColor = Colors.black87;
  Color priceColor = Theme.of(context).colorScheme.secondary;
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
              color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
              border: Border.all(
                  color: needTodayBorder
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
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
        if (needShadow) Container(color: Colors.grey.withOpacity(0.20)),
      ],
    ),
  );
}
