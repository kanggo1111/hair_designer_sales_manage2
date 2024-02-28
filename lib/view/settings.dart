import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    var _selectedValue = settingsController.colorList.indexOf(settingsController.settings.color!);

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
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
                          width: 80,
                          height: 20,
                          color: settingsController.colorMap[settingsController.colorList[index]],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(settingsController.colorList[index]),
                      ]));
                }),
              ),
              GestureDetector(
                onTap: () {
                  AuthController.instance.logout();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      Text(
                        '로그아웃 ',
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.logout)
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
