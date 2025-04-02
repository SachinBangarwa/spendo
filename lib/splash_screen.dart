import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spendo/auth/screens/on_board_screen.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/theme/color_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  void navigateUser() async {
    await Future.delayed(const Duration(seconds: 2)); // 2-second delay

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Get.offAll(() => DashBoardScreen());  // User logged in
    } else {
      Get.offAll(() => OnBoardScreen());  // User not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF7F3DFF),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: size.width / 10),
              width: size.width / 6,
              height: size.height / 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF6A0AE4),
              ),
            ),
            const Text(
              'spendo',
              style: TextStyle(
                fontSize: 50,
                color: ColorManager.lightBackground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
