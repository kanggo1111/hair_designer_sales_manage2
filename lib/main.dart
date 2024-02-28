import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hair_designer_sales_manage2/controller/auth_controller.dart';
import 'package:hair_designer_sales_manage2/firebase_options.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/view/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authController = Get.put(AuthController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hair_designer_sales_manage',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
