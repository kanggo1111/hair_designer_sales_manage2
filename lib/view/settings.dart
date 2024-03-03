import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hair_designer_sales_manage2/controller/auth_controller.dart';
import 'package:hair_designer_sales_manage2/controller/settings_controller.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SettingsController settingsController = Get.put(SettingsController());
  double dividerIndent = 10.0;

  @override
  Widget build(BuildContext context) {
    var _selectedValue = settingsController.colorList.indexOf(settingsController.settings.color!);

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('계정', style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AuthController.instance.getUserEmail(), style: TextStyle(fontSize: 20),),
                    GestureDetector(
                      onTap: () {
                        AuthController.instance.logout();
                      },
                      child: Container(
                        width: 110,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '로그아웃 ',
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(Icons.logout)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Divider(
            color: Theme.of(context).colorScheme.primary,
            height: 0,
            thickness: 1,
            indent: dividerIndent,
            endIndent: dividerIndent,
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('설정', style: TextStyle(fontSize: 18),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('테마 컬러', style: TextStyle(fontSize: 16),),
                      SizedBox(width: 20,),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary), borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                          value: _selectedValue,
                          onChanged: (selectedColorIndex) {
                            settingsController.writeSettings({'color': settingsController.colorList[selectedColorIndex!]});
                            setState(() {
                              _selectedValue = selectedColorIndex!;
                            });
                          },
                          items: List.generate(settingsController.colorMap.length, (index) {
                            return DropdownMenuItem(
                                value: index,
                                child: Row(children: [
                                  Container(
                                    width: 60,
                                    height: 20,
                                    color: settingsController.colorMap[settingsController.colorList[index]],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(settingsController.colorList[index], style: TextStyle(fontSize: 14),overflow: TextOverflow.fade,),
                                ]));
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),

        ],
      ),
    );
  }
}
