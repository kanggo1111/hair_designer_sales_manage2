import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/view/calendar.dart';
import 'package:hair_designer_sales_manage2/view/one_day_view.dart';
import 'package:hair_designer_sales_manage2/view/settings.dart';
import 'package:hair_designer_sales_manage2/view/statistics.dart';

Color appBarContentColor = Colors.white;

class MainView extends StatelessWidget {
  MainView({super.key});

  bool isLoaded = true; // TODO:

  static const routeCalendar = "/";
  static const routeOneDayView = "/one_day_view";
  static const routeStatistics = "/statistics";
  static const routeSettings = "/settings";

  static var prevRoute = routeCalendar;

  var duration = const Duration(milliseconds: 500);

  Route _onGenerateRoute(RouteSettings setting) {
    // TODO: set transition direction.
    bool dir = false;
    bool isSameRoute = false;

    if (prevRoute == routeSettings) {
      dir = true;
    }
    if(prevRoute == setting.name!){
      isSameRoute = true;
    }
    prevRoute = setting.name!;

    Get.routing.args = setting.arguments;

    if (setting.name == routeCalendar) {
      return GetPageRoute(
          page: () => Calendar(),
          transition: isSameRoute == false ? Transition.leftToRight : Transition.noTransition,
          transitionDuration: duration);
    } else if (setting.name == routeOneDayView) {
      return GetPageRoute(
          page: () => OneDayView(setting.arguments as String),
          transition: Transition.native,
          transitionDuration: duration);
    } else if (setting.name == routeStatistics) {
      return GetPageRoute(
          page: () => Statistics(),
          transition: isSameRoute == false ? dir ? Transition.leftToRight : Transition.rightToLeft : Transition.noTransition,
          transitionDuration: duration);
    } else if (setting.name == routeSettings) {
      return GetPageRoute(
          page: () => Settings(),
          transition: isSameRoute == false ? Transition.rightToLeft : Transition.noTransition,
          transitionDuration: duration);
    } else {
      throw Exception('Unknown route: ${setting.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            '디자이너 매출 관리',
            style: TextStyle(color: appBarContentColor),
          ),
          actions: [
            IconButton(
                onPressed: () {
                    Get.offAllNamed(routeCalendar, id: 1);
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: appBarContentColor,
                )),
            IconButton(
                onPressed: () {
                    Get.offAllNamed(routeStatistics, id: 1);
                },
                icon: Icon(Icons.bar_chart_sharp, color: appBarContentColor)),
            IconButton(
                onPressed: () {
                    Get.offAllNamed(routeSettings, id: 1);
                },
                icon: Icon(Icons.settings, color: appBarContentColor)),
          ],
        ),
        backgroundColor: Colors.white,
        body: isLoaded
            ? Navigator(
                key: Get.nestedKey(1),
                initialRoute: routeCalendar,
                onGenerateRoute: _onGenerateRoute)
            : Center(
                child: Text(
                    'LOADING INDICATOR'), /*SpinKitRing(color: Colors.indigo,),*/ //TODO:
              ));
  }
}
