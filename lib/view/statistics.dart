import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/item_controller.dart';
import 'package:hair_designer_sales_manage2/controller/month_item_controller.dart';
import 'package:intl/intl.dart';

late DateTime now;
late int currentYear;
late int currentMonth;

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final MonthItemController monthItemController = Get.put(MonthItemController());

  @override
  List<dynamic> tableContent = [
    // TODO:
    ['', '수량', '금액'],
    ['지명', '', ''],
    ['신규', '', ''],
    ['대체', '', ''],
    ['점판', '', ''],
    ['계', '', '']
  ];

  void initState() {
    // TODO: implement initState
    now = DateTime.now();
    currentYear = now.year;
    currentMonth = now.month;
    refreshStatistics();
    super.initState();
  }

  void setPrevMonth() {
    if (currentMonth == 1) {
      currentYear--;
      currentMonth = 12;
    } else {
      currentMonth--;
    }
    refreshStatistics();
  }

  void setNextMonth() {
    if (currentMonth == 12) {
      currentYear++;
      currentMonth = 1;
    } else {
      currentMonth++;
    }
    refreshStatistics();
  }

  void refreshStatistics(){
    monthItemController.date = int.parse(
        DateFormat('yMMdd').format(DateTime(currentYear, currentMonth, 1)));
    monthItemController.fetchMonthItem();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                        setPrevMonth();
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
                      setNextMonth();
                  },
                  child: Icon(
                    Icons.arrow_right,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
              child: GetBuilder<MonthItemController>(
                builder: (_) {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 3),
                      itemCount: 18,
                      itemBuilder: (context, index) {
                        int row = index~/3;
                        int col = index%3;
                        String text = '';
                        Color rowColor = Colors.white;

                        if(row%2 == 1){
                          rowColor = Theme.of(context).colorScheme.secondaryContainer;
                        ;
                        }

                        if(row == 0){
                          text = tableContent[row][col];
                        }
                        else if(row == 5){
                          if(col == 0){
                            text = tableContent[row][col];
                          }
                          else if(col == 1){
                            text = monthItemController.getTotalCount().toString();
                          }
                          else if(col == 2){
                            text = NumberFormat('###,###,###,###').format(monthItemController.getTotalPrice());
                          }
                        }
                        else {
                          if(col == 0){
                            text = tableContent[row][col];
                          }
                          else if(col == 1){
                            text = monthItemController.getTypeCount(itemTypeList[row-1]).toString();
                          }
                          else if(col == 2){
                            text = NumberFormat('###,###,###,###').format(monthItemController.getTypePrice(itemTypeList[row-1]));
                          }
                        }

                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black87), color: rowColor),
                          child: Text(text, style: TextStyle(fontSize: 16),),
                        );
                      });
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
