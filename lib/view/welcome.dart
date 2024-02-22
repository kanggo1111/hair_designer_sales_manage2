import 'package:flutter/material.dart';
import 'package:hair_designer_sales_manage2/controller/auth_controller.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
                    children: [
            Text('Hi'),
            IconButton(onPressed: () {
              AuthController.instance.logout();
            }, icon: Icon(Icons.logout))
                    ],
                  ),
          )),
    );
  }
}
