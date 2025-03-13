import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/screens/change_password_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class ForgetPasswordEmailSentScreen extends StatelessWidget {
  final String email;
  const ForgetPasswordEmailSentScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height / 40, horizontal: size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/email_check.png'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your email is on the way',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: size.height / 50),
                  Text.rich(
                    TextSpan(
                      text: 'Check your email - ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: email,
                          style:  const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                          ),
                        ),
                        const TextSpan(
                          text: ' and follow the instructions to reset your password.',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const Spacer(),

            CustomButton(
              text: "Back to Login",
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () {
                Get.to(() => ChangePasswordScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
