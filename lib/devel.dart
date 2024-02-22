import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String text) {
  Get.snackbar(
    'title',
    'message',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    titleText: Text(
      '사용불가',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    messageText: Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
