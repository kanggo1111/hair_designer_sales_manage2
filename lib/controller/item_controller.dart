import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';

List<String> itemTypeList = ['지명', '신규', '대체', '점판'];

class ItemController extends GetxController {
  final _items = <Item>[].obs;
  int date = 0;

  List<Item> get items => _items;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _items.bindStream(fetchItemStream());
    // ever(_items, (_) {
    //   // _items.forEach((element) {
    //   //   print(element.id);
    //   // });
    //   // print('---------------------------');
    // });
  }

  final FirebaseAuth authentication = FirebaseAuth.instance;
  late final user = authentication.currentUser;

  void addItem(Item newItem) async {
    await FirebaseFirestore.instance
        .collection('item')
        .doc(user!.uid)
        .collection('items')
        .add(newItem.toJson());
  }

  void removeItem(String docID) async{
    await FirebaseFirestore.instance
        .collection('item')
        .doc(user!.uid)
        .collection('items').doc(docID).delete();
  }

  void setDate(int newDate){
    date = newDate;
    _items.bindStream(fetchItemStream());
  }

  // TODO:
  // void editItem(){
  //
  // }
  //

  Stream<List<Item>> fetchItemStream() {
    List<Item> items = [];
    Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
        .collection('item')
        .doc(user!.uid)
        .collection('items')
        .where('date', isEqualTo: date)
        .orderBy('id')
        .snapshots();
    snapshots.listen((QuerySnapshot query) {
      if (query.docChanges.isNotEmpty) {
        items.clear();
      }
    });
    return snapshots.map((snapshot) {
      snapshot.docs.forEach((messageData) {
        items.add(Item.fromJson(messageData));
      });
      return items.toList();
    });
  }
}
