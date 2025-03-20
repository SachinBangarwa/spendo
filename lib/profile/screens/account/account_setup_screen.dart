import 'package:flutter/material.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height / 8),
            const Text(
              "Let's setup your account!",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: size.height / 50),
            const Text(
              "Account can be your bank, credit card or your wallet.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                height: 18 / 14,
              ),
            ),
            const Spacer(),
            CustomButton(
                text: "Let’s go",
                colorButton: ColorManager.primary,
                colorText: ColorManager.lightBackground,
                onTap: () {}),
            SizedBox(height: size.height / 30),
          ],
        ),
      ),
    );
  }
}