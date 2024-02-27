import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';

class MonthItemController extends GetxController {
  final _items = <Item>[];
  int date = 0;

  List<Item> get items => _items;

  final FirebaseAuth authentication = FirebaseAuth.instance;
  late final user = authentication.currentUser;

  void fetchMonthItem() async {
    QuerySnapshot<dynamic> snapshots =  await FirebaseFirestore.instance
        .collection('item')
        .doc(user!.uid)
        .collection('items')
        .where('date', isGreaterThanOrEqualTo: date, isLessThan: date+100)
        .get();

    items.clear();
    snapshots.docs.forEach((element) {
      items.add(Item.fromJson(element));
    });
    update();
  }


  int getDayPrice(int day){
    return _items.fold<int>(0, (previousValue, element) => (element.date!%1000 == day) ? previousValue + element.price! : previousValue);
  }

  int getTypePrice(String type){
    return _items.fold<int>(0, (previousValue, element) => (element.type == type) ? previousValue + element.price! : previousValue);
  }

  int getTypeCount(String type){
    return _items.fold<int>(0, (previousValue, element) => (element.type == type) ? previousValue + element.count! : previousValue);
  }

  int getTotalPrice(){
    return _items.fold<int>(0, (previousValue, element) => previousValue + element.price!);
  }

  int getTotalCount(){
    return _items.fold<int>(0, (previousValue, element) => previousValue + element.count!);
  }
}
