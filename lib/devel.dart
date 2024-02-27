import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String type, String title, String message) {
  Get.snackbar('Error message', 'User message',
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      duration: Duration(seconds: 3),
      backgroundColor: type == 'error' ? Colors.red[700] : Colors.blue[700],
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      messageText: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),));

}
