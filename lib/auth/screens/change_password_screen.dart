import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/controllers/change_password_controller.dart';
import 'package:spendo/auth/screens/forget_password_screen.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_app_bar%20_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypeNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: 'Change Password',
        onBack: () {
          FocusScope.of(context).unfocus();
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width / 20, vertical: size.height / 16),
        child: Column(
          children: [
            _buildTextField(
              size: size,
              controller: newPasswordController,
              hintText: 'New Password',
            ),
            SizedBox(height: size.height / 35),
            _buildTextField(
              size: size,
              controller: retypeNewPasswordController,
              hintText: 'Current Password',
            ),
            SizedBox(height: size.height / 30),
            CustomButton(
              text: "Continue",
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () async {
                await changePasswordController.changePassword(
                  newPasswordController.text,
                  retypeNewPasswordController.text,
                );
                Get.to(() => ForgetPasswordScreen());
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
