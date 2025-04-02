import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/controllers/forget_password_controller.dart';
import 'package:spendo/auth/screens/forget_password_email_sent_screen.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../widgets/common_app_bar _widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: 'Forget Password',
        onBack: () {
          FocusScope.of(context).unfocus();
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height / 14, horizontal: size.width / 22),
        child: Column(
          children: [
            const Text(
              "Don’t worry.\nEnter your email and we’ll send you a link to reset your password.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height / 20),
            _buildTextField(
              size: size,
              controller: emailController,
              hintText: 'Email',
            ),
            SizedBox(height: size.height / 25),
            CustomButton(
              text: "Continue",
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () {
                FocusScope.of(context).unfocus();
                if (emailController.text.isNotEmpty) {
                  forgetPasswordController
                      .forgetPassword(emailController.text.trim())
                      .then((value) {
                    Get.to(() => ForgetPasswordEmailSentScreen(
                          email: emailController.text,
                        ));
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required Size size,
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: CommonStyles.inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }
}
