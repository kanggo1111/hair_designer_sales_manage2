import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/item_controller.dart';
import 'package:hair_designer_sales_manage2/devel.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';

class OneDayView extends StatefulWidget {
  OneDayView(this.day, {super.key});

  String day;

  final itemController = Get.put(ItemController());

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
        color: Colors.white,
        child: Column(
          children: [
            Text(widget.day),
            ElevatedButton(
                onPressed: () {
                  try {
                    Item tempItem = Item(
                        date: widget.day, type: '지명', count: 3, price: 40000);
                    widget.itemController.addItem(tempItem);
                  } on Exception catch (e) {
                    // TODO
                    // showSnackBar(e.toString());
                  }
                },
                child: Text(
                  '저장',
                  style: TextStyle(fontSize: 16),
                )),
          ],
        ));
  }
}
