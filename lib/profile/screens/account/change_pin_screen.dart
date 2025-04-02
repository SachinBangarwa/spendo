import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/profile/controllers/user_detail_controller.dart';
import 'package:spendo/profile/screens/account/pin_code_screen.dart';

class ChangePinScreen extends StatelessWidget {
  final UserDetailController userDetailController =
      Get.find<UserDetailController>();

  ChangePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeScreen(
      title: "Enter your current PIN",
      onSubmit: (enteredPin) {
        if (enteredPin.join() == userDetailController.pin.value) {
          Get.to(() => const PinSetupScreen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Incorrect PIN. Try again!"),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
    );
  }
}
