import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/budget/screens/create_budget_screen.dart';
import 'package:spendo/budget/screens/detail_budget_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xFF7F3DFF),
        bottomSheet: Padding(
          padding: EdgeInsets.only(
              left: size.width / 22,
              right: size.width / 22,
              bottom: size.height / 22),
          child: CustomButton(
            text: 'Create a Budget',
            onTap: () {
              Get.to(()=>CreateBudgetScreen(title: 'Create Budget',));
            },
            colorButton: Color(0xFF7F3DFF),
            colorText: ColorManager.lightBackground,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 26, vertical: size.height / 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ColorManager.lightBackground,
                          size: 22,
                        )),
                    Text(
                      'May',
                      style: TextStyle(
                          color: ColorManager.lightBackground,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: ColorManager.lightBackground,
                          size: 22,
                        )),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 20,
                        vertical: size.height / 45),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFFCFCFC),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          double progress = 500 / 1000;
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=>DetailBudgetScreen());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.height / 55),
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width / 45,
                                            vertical: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 2, color: Colors.black12),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: size.width / 25,
                                              height: size.height / 25,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFCAC12),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width / 55,
                                            ),
                                            Text(
                                              'Category',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.error,
                                        color: Color(0xFFFD3C4A),
                                        size: 30,
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Remaining \$0',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: size.height / 99,
                                  ),
                                  LinearProgressIndicator(
                                    value: progress,
                                    minHeight: size.height / 66,
                                    borderRadius: BorderRadius.circular(20),
                                    backgroundColor: Colors.grey[300],
                                    valueColor:
                                        AlwaysStoppedAnimation(Color(0xFFFCAC12)),
                                  ),
                                  SizedBox(
                                    height: size.height / 99,
                                  ),
                                  Text(
                                    '\$1200 of \$1000',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: size.height / 150,
                                  ),
                                  Text(
                                    'You’ve exceed the limit!',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFFD3C4A),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
              ),
            ],
          ),
        ));
  }
}
