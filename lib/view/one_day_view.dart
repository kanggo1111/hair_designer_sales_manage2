import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/item_controller.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';
import 'package:intl/intl.dart';

List<int> typeCount = List.generate(itemTypeList.length, (index) => 0);
int priceOfDay = 0;

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
    FocusScope.of(context).unfocus();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    itemController.date = int.parse(widget.day.replaceAll('-', ''));

    return GetX<ItemController>(builder: (_) {
      return Container(
          color: Colors.white,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.day,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text('지명', style: TextStyle(fontSize: 15),),
                      SizedBox(height: 10,),
                      Text(itemController.items
                          .fold(
                              0,
                              (previousValue, element) => element.type == '지명'
                                  ? previousValue + element.count!
                                  : previousValue)
                          .toString(), style: TextStyle(fontSize: 18)),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text('신규', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10,),
                      Text(itemController.items
                          .fold(
                              0,
                              (previousValue, element) => element.type == '신규'
                                  ? previousValue + element.count!
                                  : previousValue)
                          .toString(), style: TextStyle(fontSize: 18)),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text('총객수', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10,),
                      Text(itemController.items
                          .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.count!)
                          .toString(), style: TextStyle(fontSize: 18)),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text('일매출', style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10,),
                      Text(NumberFormat('###,###,###,###').format(
                          itemController.items.fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.price!)), style: TextStyle(fontSize: 18)),
                    ]),
                  ),
                  SizedBox(width: 20,),
                ],
              ),
              Divider(
                height: 0,
                thickness: 3,
              ),
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
                                    child: Text(NumberFormat('###,###,###,###')
                                        .format(itemController
                                            .items[index].price))),
                              ],
                            ),
                            Container(
                              child: IconButton(
                                  onPressed: () {
                                    itemController.removeItem(
                                        itemController.items[index].id!);
                                  },
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(Icons.delete,)),
                            )
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
    });
  }
}

class AddItemContainer extends StatelessWidget {
  AddItemContainer({super.key});

  final ItemController itemController = Get.put(ItemController());

  List<TextEditingController> typeTextEditingController = List.generate(
      itemTypeList.length,
      (index) => TextEditingController()..text = typeCount[index].toString());
  TextEditingController priceTextEditingController = (TextEditingController()
    ..text = NumberFormat('###,###,###,###').format(priceOfDay));

  // List<TextEditingController> typeTextEditingController =
  //     List.generate(itemTypeList.length, (index) => TextEditingController());
  // TextEditingController priceTextEditingController = (TextEditingController());

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
                              typeCount[index] = int.parse(
                                  typeTextEditingController[index].text);
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
                                typeCount[index] = int.parse(
                                    typeTextEditingController[index].text);
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
                                        .text
                                        .length ==
                                    0) {
                                  typeTextEditingController[index].value =
                                      TextEditingValue(text: '0');
                                } else if (typeTextEditingController[index]
                                    .text
                                    .startsWith('0')) {
                                  typeTextEditingController[index]
                                      .text = int.parse(
                                          typeTextEditingController[index].text)
                                      .toString();
                                }
                                typeCount[index] = int.parse(
                                    typeTextEditingController[index].text);
                              },
                            )),
                        IconButton(
                            onPressed: () {
                              setCount(index, 1);
                              typeCount[index] = int.parse(
                                  typeTextEditingController[index].text);
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
                      key: UniqueKey(),
                      controller: priceTextEditingController,
                      keyboardType: TextInputType.number,
                      onTap: () {
                        priceTextEditingController.value =
                            TextEditingValue(text: '0');
                        priceOfDay = int.parse(priceTextEditingController
                            .value.text
                            .replaceAll(',', ''));
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
                        priceOfDay = int.parse(priceTextEditingController
                            .value.text
                            .replaceAll(',', ''));
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
                              count: typeCount[index],
                              price: index < 2
                                  ? (int.parse(priceTextEditingController
                                              .value.text
                                              .replaceAll(',', '')) *
                                          (int.parse(typeTextEditingController[index].value.text) /
                                              (int.parse(
                                                      typeTextEditingController[0]
                                                          .value
                                                          .text) +
                                                  int.parse(
                                                      typeTextEditingController[1]
                                                          .value
                                                          .text))))
                                      .round()
                                  : 0));
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
