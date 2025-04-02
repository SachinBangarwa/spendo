import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/profile/screens/setting/currency_screen.dart';
import 'package:spendo/profile/screens/setting/language_screen.dart';
import 'package:spendo/profile/screens/setting/notification_screen.dart';
import 'package:spendo/profile/screens/setting/security_screen.dart';
import 'package:spendo/profile/screens/setting/theme_screen.dart';
import 'package:spendo/widgets/common_app_bar%20_widget.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final List<String> settings = [
    'Currency',
    'Language',
    'Theme',
    'Security',
    'Notification',
  ];

  final List<String> values = [
    'USD',
    'English',
    'Dark',
    'Fingerprint',
    '',
  ];

  List<Widget> widgets = [
    CurrencyScreen(),
    LanguageScreen(),
    ThemeScreen(),
    SecurityScreen(),
    const NotificationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'Settings',
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
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: settings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(() => widgets[index]);
                    },
                    contentPadding: EdgeInsets.only(
                      left: size.width / 22,
                    ),
                    title: Text(
                      settings[index],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          values[index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios, size: 20),
                          color: const Color(0xFF7F3DFF),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: size.height / 55,
              ),
              ListTile(
                contentPadding: EdgeInsets.only(
                  left: size.width / 22,
                ),
                onTap: () {},
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF7F3DFF),
                      size: 20,
                    )),
                title: const Text(
                  "About",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(
                  left: size.width / 22,
                ),
                onTap: () {},
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF7F3DFF),
                      size: 20,
                    )),
                title: const Text(
                  "Help",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
