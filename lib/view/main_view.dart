import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/devel.dart';
import 'package:hair_designer_sales_manage2/view/calendar.dart';
import 'package:hair_designer_sales_manage2/view/settings.dart';
import 'package:hair_designer_sales_manage2/view/statistics.dart';

Color appBarContentColor = Colors.white;

class MainView extends StatelessWidget {
  MainView({super.key});

  bool _isLoaded = true; // TODO:
  final _navigatorKey = GlobalKey<NavigatorState>();

  static const routeCalendar = "/";
  static const routeStatistics = "/statistics";
  static const routeSettings = "/settings";

  static var prevRoute = routeCalendar;

  Route _onGenerateRoute(RouteSettings setting) {
    // TODO: set transition direction.
    bool dir = false;
    if(prevRoute == routeSettings){
      dir = true;
    }
    prevRoute = setting.name!;

    if (setting.name == routeCalendar) {
      return GetPageRoute(
        page: () => Calendar(),
        transition: Transition.leftToRight,
      );
    } else if (setting.name == routeStatistics) {
      return GetPageRoute(
        page: () => Statistics(),
        transition: dir ? Transition.leftToRight : Transition.rightToLeft,
      );
    }
    else if (setting.name == routeSettings) {
      return GetPageRoute(
        page: () => Settings(),
        transition: Transition.rightToLeft,
      );
    }
    else {
      throw Exception('Unknown route: ${setting.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Main View',
            style: TextStyle(color: appBarContentColor),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(routeCalendar, id: 1);
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: appBarContentColor,
                )),
            IconButton(
                onPressed: () {
                  Get.toNamed(routeStatistics, id: 1);
                },
                icon: Icon(Icons.bar_chart_sharp, color: appBarContentColor)),
            IconButton(
                onPressed: () {
                  Get.toNamed(routeSettings, id: 1);
                },
                icon: Icon(Icons.settings, color: appBarContentColor)),
          ],
        ),
        backgroundColor: Colors.white,
        body: _isLoaded
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
