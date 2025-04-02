import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/profile/controllers/user_detail_controller.dart';
import 'package:spendo/profile/screens/account/account_screen.dart';
import 'package:spendo/profile/screens/account/pin_code_screen.dart';

class EnterPinScreen extends StatelessWidget {
  final UserDetailController userDetailController = Get.find<UserDetailController>();

  EnterPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeScreen(
      title: "Enter your PIN",
      onSubmit: (enteredPin) {
        if (enteredPin.join() == userDetailController.pin.value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("PIN Verified Successfully!")),
          );
          Get.off(() => AccountScreen())!.then((_) {
            Get.offAll(() => DashBoardScreen(selectedIndex: 3));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Incorrect PIN, try again!")),
          );

        }
      },
    );
  }
}
