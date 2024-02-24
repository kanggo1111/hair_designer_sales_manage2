import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';

List<String> itemTypeList = ['지명', '신규', '대체', '점판'];

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
      update();
    });
  }

  int getMonthPrice(){
    return _items.fold<int>(0, (previousValue, element) => previousValue + element.price!);
  }

  int getDayPrice(int day){
    return _items.fold<int>(0, (previousValue, element) => (element.date!%1000 == day) ? previousValue + element.price! : previousValue);
  }
}
