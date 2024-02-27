import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hair_designer_sales_manage2/controller/auth_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  AuthController.instance.logout();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Row(children: [
                    Text('로그아웃 ', style: TextStyle(fontSize: 18),),
                    Icon(Icons.logout)
                  ],),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
