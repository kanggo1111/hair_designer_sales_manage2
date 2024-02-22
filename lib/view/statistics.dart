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
  List<dynamic> tableContent = [
    // TODO:
    ['', '수량', '금액'],
    ['지명', '1', '100,000'],
    ['신규', '2', '200,000'],
    ['매출', '3', '300,000'],
    ['점판', '4', '400,000'],
    ['계', '10', '1000,000']
  ];

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
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 3),
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
                      // TODO: fill tile with data
                      // TODO: modify ui
                      child: Text(tableContent[(index/3).toInt()][index%3], style: TextStyle(),),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
