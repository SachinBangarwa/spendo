import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';

import '../../../widgets/common_app_bar _widget.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final List<String> languageList = [
    'English (EN)',
    'Indonesian (ID)',
    'Arabic (AR)',
    'Chinese (ZH)',
    'Dutch (NL)',
    'French (FR)',
    'German (DE)',
    'Italian (IT)',
    'Korean (KO)',
    'Portuguese (PT)',
    'Russian (RU)',
    'Spanish (ES)',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Language',
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
              itemCount: languageList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.only(
                    left: size.width / 22,
                  ),
                  onTap: () {},
                  title: Text(
                    languageList[index],
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
