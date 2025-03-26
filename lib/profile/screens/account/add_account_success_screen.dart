import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/profile/screens/account/account_screen.dart';
import 'package:spendo/theme/color_manager.dart';

class AddAccountSuccessScreen extends StatefulWidget {
  const AddAccountSuccessScreen({super.key});

  @override
  State<AddAccountSuccessScreen> createState() =>
      _AddAccountSuccessScreenState();
}

class _AddAccountSuccessScreenState extends State<AddAccountSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveAccountScreen();
  }
  Future moveAccountScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() => AccountScreen())!.then((_) {
      Get.offAll(() => DashBoardScreen(selectedIndex: 3));
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/success_account.json',
                height: 200, width: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            const Text(
              "You are set!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
