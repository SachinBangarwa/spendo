import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';

import '../../../widgets/common_app_bar _widget.dart';

class ThemeScreen extends StatelessWidget {
  ThemeScreen({super.key});

  final List<String> themeList = ['Light', 'Dark', 'Use device theme'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Theme',
        onBack: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.black12,
            height: size.height / 88,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: themeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.only(
                    left: size.width / 22,
                  ),
                  onTap: () {},
                  title: Text(
                    themeList[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
