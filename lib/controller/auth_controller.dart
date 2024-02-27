import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/devel.dart';
import 'package:hair_designer_sales_manage2/view/login.dart';
import 'package:hair_designer_sales_manage2/view/main_view.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  bool afterRegister = false;
  bool afterLogin = false;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user != null && user.emailVerified == true) {
      Get.offAll(() => MainView(), transition: Transition.noTransition);
    } else if (user != null && user.emailVerified == false) {
      if (afterLogin == true) {
        showSnackBar('error', '로그인 실패', 'Email 인증을 완료하세요');
      } else if (afterRegister == true) {
        showSnackBar('info', 'Email 인증 메일 발송',
            '입력하신 Email로 인증 메일을 보냈습니다. 메일에서 인증링크에 접속하세요.');
      }

      authentication.signOut();
      Get.offAll(() => Login(), transition: Transition.noTransition);
    } else {
      Get.offAll(() => Login(), transition: Transition.noTransition);
    }

    afterRegister = false;
    afterLogin = false;
  }

  void register(String email, password) async {
    try {
      afterRegister = true;

      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);

      final currentUser = authentication.currentUser;
      if (currentUser != null) {
        currentUser.sendEmailVerification();
        authentication.signOut();
      }
      // await sendEmailVerification(authentication.currentUser);
    } catch (e) {
      Get.snackbar('Error message', 'User message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            'Registration is failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void login(String email, password) async {
    try {
      afterLogin = true;
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar('Error message', 'User message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            'login is failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void logout() {
    authentication.signOut();
  }
}
