import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/model/Item.dart';

class ItemController extends GetxController{
  var items = <Item>[].obs;

  final FirebaseAuth authentication = FirebaseAuth.instance;
  late final user = authentication.currentUser;

  void addItem(Item newItem) async{
    final userData = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat-${user!.email}').add(newItem.toJson());
  }

  // void removeItem(){
  //
  // }
  //
  // void editItem(){
  //
  // }
  //
  // void getItem(){
  //
  // }
}