import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';

class ItemController extends GetxController {
  var _items = <Item>[].obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _items.bindStream(fetchItemStream());
    ever(_items, (_) {
      _items.forEach((element) {
        print(element.id);
      });
      print('---------------------------');
    });
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

  // void removeItem(){
  //
  // }
  //
  // void editItem(){
  //
  // }
  //
  // List<Item> readItem(){
  //
  //
  //   return [];
  // }

  Stream<List<Item>> fetchItemStream() {
    List<Item> items = [];
    Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
        .collection('item')
        .doc(user!.uid)
        .collection('items')
        .orderBy('id', descending: true)
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
      // print('Total message fetched: ${items.length}');
      // items.toList().forEach((element) {
      //   print(element.id);
      //   print(element.date);
      //   print(element.type);
      //   print(element.count);
      //   print(element.price);
      //   print('----------------');
      // });
      return items.toList();
    });
  }
}
