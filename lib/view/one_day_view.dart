import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneDayView extends StatefulWidget {
  OneDayView(this.day, {super.key});
  String day;

  @override
  State<OneDayView> createState() => _OneDayViewState();
}

class _OneDayViewState extends State<OneDayView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Get.back(id: 1);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.day, style: TextStyle(fontSize: 40),)
            ],
          )
        ],
      ),
    );
  }
}
