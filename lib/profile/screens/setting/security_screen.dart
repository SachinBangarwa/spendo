import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/profile/controllers/user_detail_controller.dart';
import 'package:spendo/profile/screens/account/change_pin_screen.dart';
import 'package:spendo/profile/screens/account/pin_code_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import '../../../widgets/common_app_bar _widget.dart';

class SecurityScreen extends StatelessWidget {
  SecurityScreen({super.key});

  final UserDetailController userDetailController =
      Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      bool isPinSet = userDetailController.pin.value.isNotEmpty;

      List<String> securityList =
          isPinSet ? ['Change PIN', 'Remove PIN'] : ['Set PIN'];

      return Scaffold(
        backgroundColor: ColorManager.lightBackground,
        appBar: CommonAppBar(
          title: 'Security',
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
              itemCount: securityList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: size.width / 22),
                  onTap: () {
                    if (securityList[index] == 'Set PIN') {
                      Get.to(() => const PinSetupScreen());
                    } else if (securityList[index] == 'Change PIN') {
                      Get.to(() => ChangePinScreen());
                    } else if (securityList[index] == 'Remove PIN') {
                      _removePin(context);
                    }
                  },
                  title: Text(
                    securityList[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  void _removePin(context) {
    Get.to(() => PinCodeScreen(
          title: "Enter your PIN to Remove",
          onSubmit: (enteredPin) async {
            if (enteredPin.join() == userDetailController.pin.value) {
              await userDetailController.removePin();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("PIN removed successfully!"),
                  duration: Duration(seconds: 1),
                ),
              );
              Get.back();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Incorrect PIN, try again!"),
                  duration: Duration(seconds: 1),
                ),
              );
            }
          },
        ));
  }
}
