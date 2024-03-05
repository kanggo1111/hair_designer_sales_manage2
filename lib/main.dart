import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hair_designer_sales_manage2/controller/auth_controller.dart';
import 'package:hair_designer_sales_manage2/controller/settings_controller.dart';
import 'package:hair_designer_sales_manage2/firebase_options.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/view/login.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authController = Get.put(AuthController());
  final SettingsController settingsController = Get.put(SettingsController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (_) {
      return GetMaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Hair_designer_sales_manage',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: settingsController
                  .getColor(settingsController.settings.color!)),
          useMaterial3: true,
        ),
        home: Login(),
      );
    });
  }
}
