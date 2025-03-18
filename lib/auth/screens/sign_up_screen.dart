import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/controllers/sign_up_controller.dart';
import 'package:spendo/auth/screens/login_screen.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';

import '../../widgets/common_appBar _widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController signUpController = Get.put(SignUpController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: 'Sign Up',
        onBack: () async {
          FocusScope.of(context).unfocus();
          await Future.delayed(const Duration(milliseconds: 300));
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height / 14),
            _buildTextField(size, nameController, 'Name'),
            SizedBox(height: size.height / 30),
            _buildTextField(size, emailController, 'Email'),
            SizedBox(height: size.height / 30),
            _buildPasswordField(size),
            SizedBox(height: size.height / 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      activeColor: ColorManager.primary,
                      checkColor: ColorManager.lightText,
                      side: const BorderSide(
                          color: ColorManager.primary, width: 2),
                      value: signUpController.agreeCheckPrivacy.value,
                      onChanged: (changeValue) {
                        signUpController.agreeCheckPrivacy.value =
                            changeValue ?? false;
                      },
                    ),
                  ),
                ),
                SizedBox(width: size.width / 65),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        children: [
                          TextSpan(text: 'By signing up, you agree to the '),
                          TextSpan(
                            text: 'Terms of Service and Privacy Policy',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height / 30),
            CustomButton(
              text: "Sign Up",
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () async {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (name.isNotEmpty &&
                    email.isNotEmpty &&
                    password.isNotEmpty) {
                  User? user =
                      await signUpController.signUpCloud(name,email, password);
                  if (user != null) {
                    Get.to(() => LoginScreen());
                  }
                } else {
                  showCustomSnackBar("Field", "All details are required",
                      isSuccess: false);
                }
              },
            ),
            SizedBox(height: size.height / 55),
            const Align(
              child: Text('Or with',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ),
            SizedBox(height: size.height / 25),
            GestureDetector(
              onTap: () async {
                await signUpController.signWithGoogle().then((bool isVerify) {
                  // if (isVerify) {
                 Get.offAll(()=>DashBoardScreen());
                  // }
                });
              },
              child: Container(
                width: size.width,
                height: size.height / 13,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.lightBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD6CDE4), width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.png',
                        height: size.height / 20),
                    SizedBox(width: size.width / 35),
                    const Text('Sign Up with Google',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700)),
                TextButton(
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Text(
                    "Login",
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

  Widget _buildPasswordField(Size size) {
    return Obx(() => TextFormField(
      controller: passwordController,
      obscureText: signUpController.visible.value,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: CommonStyles.inputDecoration('Password', size).copyWith(
        suffixIcon: GestureDetector(
          onTap: signUpController.visible.toggle,
          child: Icon(
            signUpController.visible.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ),
      cursorColor: ColorManager.primary,
    ));
  }

  Widget _buildTextField(
      Size size, TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: CommonStyles.inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }

}
