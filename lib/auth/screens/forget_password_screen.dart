import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/controllers/forget_password_controller.dart';
import 'package:spendo/auth/screens/forget_password_email_sent_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../widgets/common_appBar _widget.dart';

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
            Text(
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
      decoration: _inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }

  InputDecoration _inputDecoration(String hintText, Size size) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: size.width / 20, vertical: size.height / 46),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFFDEEDB), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.primary, width: 2),
      ),
    );
  }
}
