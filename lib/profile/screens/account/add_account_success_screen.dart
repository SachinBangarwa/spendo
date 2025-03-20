import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spendo/theme/color_manager.dart';

class AddAccountSuccessScreen extends StatelessWidget {
  const AddAccountSuccessScreen({super.key});

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
