import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/item_controller.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';
import 'package:intl/intl.dart';

class OneDayView extends StatefulWidget {
  OneDayView(this.day, {super.key});

  String day;

  @override
  State<OneDayView> createState() => _OneDayViewState();
}

class _OneDayViewState extends State<OneDayView> {
  final ItemController itemController = Get.put(ItemController());

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
    itemController.date = widget.day;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetX<ItemController>(builder: (_) {
        return Container(
            color: Colors.white,
            child: Column(
              children: [
                Text(widget.day),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemController.items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      alignment: Alignment.center,
                                      child: Text(index.toString())),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      alignment: Alignment.center,
                                      child: Text(
                                          itemController.items[index].type!)),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      alignment: Alignment.center,
                                      child: Text(itemController
                                              .items[index].count
                                              .toString() +
                                          '명')),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      alignment: Alignment.center,
                                      child: Text(
                                          NumberFormat('###,###,###,###')
                                              .format(itemController
                                                  .items[index].price))),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    itemController.removeItem(
                                        itemController.items[index].id!);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        );
                      }),
                ),
                Divider(
                  height: 0,
                  thickness: 3,
                ),
                AddItemContainer(),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ));
      }),
    );
  }
}

class AddItemContainer extends StatelessWidget {
  AddItemContainer({super.key});

  final ItemController itemController = Get.put(ItemController());

  List<TextEditingController> typeTextEditingController = List.generate(
      itemTypeList.length, (index) => TextEditingController()..text = '0');
  TextEditingController priceTextEditingController =
      (TextEditingController()..text = '0');

  @override
  Widget build(BuildContext context) {
    void setCount(int index, int delta) {
      if (int.parse(typeTextEditingController[index].value.text) < 1 &&
          delta == -1) {
        return;
      } else if (int.parse(typeTextEditingController[index].value.text) >= 99 &&
          delta == 1) {
        return;
      }

      typeTextEditingController[index].value = TextEditingValue(
          text: (int.parse(typeTextEditingController[index].value.text) + delta)
              .toString());
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: List.generate(
                itemTypeList.length,
                (index) => Row(
                      children: [
                        Text(
                          itemTypeList[index].toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {
                              setCount(index, -1);
                            },
                            icon: Icon(Icons.remove_circle_outline,
                                color: Colors.black45)),
                        Container(
                            width: 60,
                            height: 30,
                            child: TextField(
                              controller: typeTextEditingController[index],
                              keyboardType: TextInputType.number,
                              onTap: () {
                                typeTextEditingController[index].value =
                                    TextEditingValue(text: '0');
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter(
                                    RegExp('^[0-9]{1,2}\$'),
                                    allow: true),
                              ],
                              decoration: InputDecoration(isDense: true),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                if (typeTextEditingController[index]
                                        .value
                                        .text
                                        .length >
                                    1) {
                                  if (typeTextEditingController[index]
                                      .value
                                      .text
                                      .startsWith('0')) {
                                    typeTextEditingController[index].value =
                                        TextEditingValue(
                                            text: typeTextEditingController[
                                                    index]
                                                .value
                                                .text
                                                .substring(
                                                    1,
                                                    typeTextEditingController[
                                                            index]
                                                        .value
                                                        .text
                                                        .length));
                                  }
                                }
                              },
                            )),
                        IconButton(
                            onPressed: () {
                              setCount(index, 1);
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.black45,
                            )),
                      ],
                    )),
          ),
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '매출액',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: TextField(
                      controller: priceTextEditingController,
                      keyboardType: TextInputType.number,
                      onTap: () {
                        priceTextEditingController.value =
                            TextEditingValue(text: '0');
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp('[0-9,]'),
                            allow: true),
                        CurrencyTextInputFormatter(
                            locale: 'ko-KR', decimalDigits: 0, symbol: '')
                      ],
                      decoration: InputDecoration(isDense: true),
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.end,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        if (priceTextEditingController.value.text.length < 4) {
                          priceTextEditingController.value = TextEditingValue(
                              text: priceTextEditingController.value.text +
                                  ',000');
                        }
                        priceTextEditingController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: priceTextEditingController
                                        .value.text.length -
                                    4));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    try {
                      for (int index = 0;
                          index < itemTypeList.length;
                          index++) {
                        if (int.parse(
                                typeTextEditingController[index].value.text) >
                            0) {
                          itemController.addItem(Item(
                              date: itemController.date,
                              type: itemTypeList[index],
                              count: int.parse(
                                  typeTextEditingController[index].value.text),
                              price: int.parse(priceTextEditingController
                                  .value.text
                                  .replaceAll(',', ''))));
                        }
                      }
                    } on Exception catch (e) {
                      // TODO
                      // showSnackBar(e.toString());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '저장',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
