import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/item_controller.dart';
import 'package:hair_designer_sales_manage2/controller/month_item_controller.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';
import 'package:hair_designer_sales_manage2/view/main_view.dart';
import 'package:intl/intl.dart';

List<int> typeCount = [];
int priceOfDay = 0;

class OneDayView extends StatefulWidget {
  OneDayView(this.day, {super.key});

  String day;

  @override
  State<OneDayView> createState() => _OneDayViewState();
}

class _OneDayViewState extends State<OneDayView> {
  final ItemController itemController = Get.put(ItemController());
  int currentYear = 0;
  int currentMonth = 0;
  int currentDay = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BackButtonInterceptor.add(myInterceptor);

    typeCount = List.generate(itemTypeList.length, (index) => 0);
    priceOfDay = 0;

    currentYear = DateTime.parse(widget.day).year;
    currentMonth = DateTime.parse(widget.day).month;
    currentDay = DateTime.parse(widget.day).day;

    itemController.setDate(int.parse(widget.day.replaceAll('-', '')));
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
    Get.find<MonthItemController>().fetchMonthItem();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Offset dragStart = Offset(0.0, 0.0);
    Offset dragEnd = Offset(0.0, 0.0);

    return GetX<ItemController>(builder: (_) {
      return Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (details) {
                    dragStart = details.localPosition;
                  },
                  onPanUpdate: (details) {
                    dragEnd = details.localPosition;
                  },
                  onPanEnd: (details) {
                    if ((dragEnd.dx - dragStart.dx).abs() >
                        (dragEnd.dy - dragStart.dy).abs()) {
                      if (dragEnd.dx - dragStart.dx > 0) {
                        Get.toNamed(MainView.routeOneDayView,
                            arguments: DateFormat('y-MM-dd').format(DateTime(
                                currentYear, currentMonth, currentDay - 1)),
                            id: 1);
                      } else if (dragEnd.dx - dragStart.dx < 0) {
                        Get.toNamed(MainView.routeOneDayView,
                            arguments: DateFormat('y-MM-dd').format(DateTime(
                                currentYear, currentMonth, currentDay + 1)),
                            id: 1);
                      }
                    }
                  },
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            widget.day,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        height: 0,
                        thickness: 3,
                      ),
                      Container(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text(
                                  '지명',
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    itemController.items
                                        .fold(
                                            0,
                                            (previousValue, element) =>
                                                element.type == '지명'
                                                    ? previousValue +
                                                        element.count!
                                                    : previousValue)
                                        .toString(),
                                    style: TextStyle(fontSize: 18)),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text('신규', style: TextStyle(fontSize: 15)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    itemController.items
                                        .fold(
                                            0,
                                            (previousValue, element) =>
                                                element.type == '신규'
                                                    ? previousValue +
                                                        element.count!
                                                    : previousValue)
                                        .toString(),
                                    style: TextStyle(fontSize: 18)),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text('총객수', style: TextStyle(fontSize: 15)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    itemController.items
                                        .fold(
                                            0,
                                            (previousValue, element) =>
                                                previousValue + element.count!)
                                        .toString(),
                                    style: TextStyle(fontSize: 18)),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Text('일매출', style: TextStyle(fontSize: 15)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    NumberFormat('###,###,###,###').format(
                                        itemController.items.fold(
                                            0,
                                            (previousValue, element) =>
                                                previousValue +
                                                element.price!)),
                                    style: TextStyle(fontSize: 18)),
                              ]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        height: 0,
                        thickness: 3,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: itemController.items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          alignment: Alignment.center,
                                          child: Text(index.toString())),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          alignment: Alignment.center,
                                          child: Text(itemController
                                              .items[index].type!)),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          alignment: Alignment.center,
                                          child: Text(itemController
                                                  .items[index].count
                                                  .toString() +
                                              '명')),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          alignment: Alignment.center,
                                          child: Text(
                                              NumberFormat('###,###,###,###')
                                                  .format(itemController
                                                      .items[index].price))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: IconButton(
                                            onPressed: () {
                                              print('edit');
                                              showEditDialog(context,
                                                  itemController.items[index]);
                                              // itemController.editItem(itemController.items[index].id!);
                                            },
                                            visualDensity:
                                                VisualDensity.compact,
                                            icon: Icon(
                                              Icons.edit,
                                            )),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: IconButton(
                                            onPressed: () {
                                              itemController.removeItem(
                                                  itemController
                                                      .items[index].id!);
                                            },
                                            visualDensity:
                                                VisualDensity.compact,
                                            icon: Icon(
                                              Icons.delete,
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary,
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
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        Container(
                          width: 60,
                          height: 30,
                          child: countTextField(
                              typeTextEditingController[index],
                              typeCount,
                              index),
                        ),
                        IconButton(
                            onPressed: () {
                              setCount(index, 1);
                              typeCount[index] = int.parse(
                                  typeTextEditingController[index].text);
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Theme.of(context).colorScheme.secondary,
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
                        if (priceTextEditingController.value.text.length < 2) {
                          priceTextEditingController.value = TextEditingValue(
                              text:
                                  priceTextEditingController.value.text + '00');
                        }
                        priceTextEditingController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: priceTextEditingController
                                        .value.text.length -
                                    2));
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

Widget countTextField(
    TextEditingController textEditingController, List countList, int index) {
  return TextField(
    controller: textEditingController,
    keyboardType: TextInputType.number,
    onTap: () {
      textEditingController.value = TextEditingValue(text: '0');
      countList[index] = int.parse(textEditingController.text);
    },
    inputFormatters: [
      FilteringTextInputFormatter(RegExp('^[0-9]{1,2}\$'), allow: true),
    ],
    decoration: InputDecoration(isDense: true),
    textAlign: TextAlign.center,
    textAlignVertical: TextAlignVertical.center,
    onChanged: (value) {
      if (textEditingController.text.length == 0) {
        textEditingController.value = TextEditingValue(text: '0');
      } else if (textEditingController.text.startsWith('0')) {
        textEditingController.text =
            int.parse(textEditingController.text).toString();
      }
      countList[index] = int.parse(textEditingController.text);
    },
  );
}

void showEditDialog(BuildContext context, Item toEditItem) {
  showDialog(
      context: context,
      builder: (context) {
        return EditDialog(toEditItem);
      });
}

class EditDialog extends StatefulWidget {
  EditDialog(this.toEditItem, {super.key});

  Item toEditItem;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  String type = '';
  int count = 0;
  int price = 0;

  TextEditingController countController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = widget.toEditItem.type!;
    count = widget.toEditItem.count!;
    price = widget.toEditItem.price!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text('수정하려는 항목을 탭하세요'),
      content: Row(children: [
        OutlinedButton(onPressed: () {}, child: Text(type)),
        OutlinedButton(onPressed: () {}, child: Text(count.toString())),
        TextField(),
        OutlinedButton(
            onPressed: () {},
            child: Text(NumberFormat('###,###,###').format(price))),
      ]),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('수정',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.primary))),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.background),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        ),
      ],
    );
  }
}
