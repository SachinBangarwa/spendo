import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/controllers/on_board_controller.dart';
import 'package:spendo/auth/model/on_board_model.dart';
import 'package:spendo/auth/screens/login_screen.dart';
import 'package:spendo/auth/screens/sign_up_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({super.key});

  final OnBoardController onBoardController = Get.put(OnBoardController());
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: size.width / 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height / 20),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  onBoardController.changeValue(value);
                },
                itemCount: OnBoardModel.contentList.length,
                itemBuilder: (context, index) {
                  OnBoardModel onBoardModel = OnBoardModel.contentList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        onBoardModel.imgUrl,
                        height: size.height / 2.7,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: size.height / 25),
                      Text(
                        onBoardModel.title,
                        style: const TextStyle(
                            fontSize: 32,
                            height: 0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0),
                      ),
                      SizedBox(height: size.height / 65),
                      Text(
                        onBoardModel.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Obx(() {
                  bool isBool = onBoardController.changeIndex.value == index;
                  return Padding(
                    padding: EdgeInsets.all(size.width / 40),
                    child: CircleAvatar(
                      radius: isBool ? size.height / 120 : size.height / 200,
                      backgroundColor:
                      isBool ? ColorManager.primary : const Color(0xFFEEE5FF),
                    ),
                  );
                });
              }),
            ),
            SizedBox(height: size.height / 30),

            CustomButton(
              text: "Sign Up",
              colorButton: ColorManager.primary,
              colorText: ColorManager.darkText,
              onTap: () {
                Get.to(() => SignUpScreen());
              },
            ),

            SizedBox(height: size.height / 50),

            CustomButton(
              text: "Login",
              colorButton: const Color(0xFFEEE5FF),
              colorText: ColorManager.primary,
              onTap: () {
        Get.to(()=>LoginScreen());
              },
            ),

            SizedBox(height: size.height / 50),
          ],
        ),
      ),
    );
  }
}
