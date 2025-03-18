import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/controllers/login_controller.dart';
import 'package:spendo/auth/screens/forget_password_screen.dart';
import 'package:spendo/auth/screens/sign_up_screen.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../widgets/common_appBar _widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: 'Login',
        onBack: () {
          FocusScope.of(context).unfocus();
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height / 10),
            _buildTextField(size, emailController, 'Email'),
            SizedBox(height: size.height / 30),
            _buildPasswordField(size),
            SizedBox(height: size.height / 30),

            CustomButton(
              text: "Login",
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  User? user = await loginController.loginCloud(email, password);
                  if (user != null) {
                    Get.to(() => DashBoardScreen());
                    Get.snackbar('SuccessFull', 'Login Account $email',
                        backgroundColor: ColorManager.lightText,
                        colorText: ColorManager.lightBackground);
                  }
                } else {
                  Get.snackbar('Field', 'All Detail Set Required',
                      backgroundColor: ColorManager.lightText,
                      colorText: ColorManager.lightBackground);
                }
              },
            ),

            SizedBox(height: size.height / 55),
            Align(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                )),
            SizedBox(height: size.height / 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: ColorManager.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(Size size, TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: _inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }

  Widget _buildPasswordField(Size size) {
    return Obx(() => TextFormField(
      controller: passwordController,
      obscureText: loginController.visible.value,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: _inputDecoration('Password', size).copyWith(
        suffixIcon: GestureDetector(
          onTap: loginController.visible.toggle,
          child: Icon(
            loginController.visible.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ),
      cursorColor: ColorManager.primary,
    ));
  }

  InputDecoration _inputDecoration(String hintText, Size size) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 16),
      contentPadding: EdgeInsets.symmetric(horizontal: size.width / 20, vertical: size.height / 46),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: ColorManager.primary)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Color(0xFFFDEEDB), width: 2)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: ColorManager.primary, width: 2)),
    );
  }
}
