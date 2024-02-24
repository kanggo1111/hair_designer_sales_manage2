import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';

List<String> itemTypeList = ['지명', '신규', '대체', '점판'];

class MonthItemController extends GetxController {
  final _items = <Item>[].obs;
  String date = '';

  List<Item> get items => _items;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  final FirebaseAuth authentication = FirebaseAuth.instance;
  late final user = authentication.currentUser;

  void fetchMonthItem() async {
    QuerySnapshot<dynamic> snapshots =  await FirebaseFirestore.instance
        .collection('item')
        .doc(user!.uid)
        .collection('items')
        .where('date', isGreaterThan: date.substring(0, 7))
        .get();

    snapshots.docs.forEach((element) {
      print(element);
      items.add(Item.fromJson(element));
    });
  }

// Stream<List<Item>> fetchItemStream() {
//   List<Item> items = [];
//   Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
//       .collection('item')
//       .doc(user!.uid)
//       .collection('items')
//       .where('date', isEqualTo: date)
//       .orderBy('id')
//       .snapshots();
//   snapshots.listen((QuerySnapshot query) {
//     if (query.docChanges.isNotEmpty) {
//       items.clear();
//     }
//   });
//   return snapshots.map((snapshot) {
//     snapshot.docs.forEach((messageData) {
//       items.add(Item.fromJson(messageData));
//     });
//     return items.toList();
//   });
// }
}
