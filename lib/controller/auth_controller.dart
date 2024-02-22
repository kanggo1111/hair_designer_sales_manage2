import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/view/login.dart';
import 'package:hair_designer_sales_manage2/view/welcome.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => Login());
    }
    else{
      Get.offAll(() => Welcome());
    }
  }

  void register(String email, password) async {
    try {
      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar('Error message', 'User message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text('Registration is failed', style: TextStyle(color: Colors.white),),
          messageText: Text(e.toString(), style: TextStyle(color: Colors.white),));
    }
  }
}
