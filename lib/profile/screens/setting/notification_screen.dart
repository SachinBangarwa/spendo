import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';

import '../../../widgets/common_app_bar _widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isExpenseAlert = false;
  bool isBudget = false;
  bool isTipsArticles = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Notification',
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
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width / 22,
            ),
            trailing: Switch(
              value: isExpenseAlert,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFEEE5FF),
              activeTrackColor: const Color(0XFF7F3DFF),
              onChanged: (value) {
                setState(() {
                  isExpenseAlert = value;
                });
              },
            ),
            title: const Text(
              'Expense Alert',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              "Get notification about your\nexpenses",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width / 22,
            ),
            trailing: Switch(
              value: isBudget,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFEEE5FF),
              activeTrackColor: const Color(0XFF7F3DFF),
              onChanged: (value) {
                setState(() {
                  isBudget = value;
                });
              },
            ),
            title: const Text(
              'Budget',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              'Get notification when your\nbudget exceeds the limit',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width / 22,
            ),
            trailing: Switch(
              value: isTipsArticles,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFEEE5FF),
              activeTrackColor: const Color(0XFF7F3DFF),
              onChanged: (value) {
                setState(() {
                  isTipsArticles = value;
                });
              },
            ),
            title: const Text(
              'Tips & Articles',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              'Small & useful pieces of practical\nfinancial advice',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
