import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/budget/screens/create_budget_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class DetailBudgetScreen extends StatelessWidget {
  const DetailBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Detail Budget',
        textColor: ColorManager.lightText,
        iconColor: ColorManager.lightText,
        backGroundCol: ColorManager.lightBackground,
        trailing: Padding(
          padding: EdgeInsets.only(right: size.width / 22),
          child: Icon(
            Icons.restore_from_trash,
            size: 28,
            color: ColorManager.lightText,
          ),
        ),
        onBack: () => Get.back(),
        onTrailingTap: () {
          _removeBudgetButton(context, size);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width / 16, vertical: size.height / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 22, vertical: size.height / 55),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                          color: Color(0xFFFCAC12),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.person),
                    ),
                    SizedBox(
                      width: size.width / 55,
                    ),
                    Text(
                      'Category',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Text(
              'Reamaing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              '\$0',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: size.height / 55,
            ),
            LinearProgressIndicator(
              value: 100 / 100,
              minHeight: size.height / 66,
              borderRadius: BorderRadius.circular(20),
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(Color(0xFFFCAC12)),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 25, vertical: size.height / 99),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFFD3C4A)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error,
                    color: ColorManager.lightBackground,
                    size: 30,
                  ),
                  SizedBox(
                    width: size.width / 55,
                  ),
                  Text(
                    'You’ve exceed the limit!',
                    style: TextStyle(
                        fontSize: 14,
                        color: ColorManager.lightBackground,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              text: 'Edit',
              onTap: () {
                Get.to(()=>CreateBudgetScreen(title: 'Edit Budget',));
              },
              colorButton: Color(0xFF7F3DFF),
              colorText: ColorManager.lightBackground,
            ),
          ],
        ),
      ),
    );
  }

  void _removeBudgetButton(BuildContext context, Size size) {
      showModalBottomSheet(
        context: context,
        builder: (index) {
          return Container(
            height: size.height / 3.8,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(6),
                  width: size.width / 8,
                  height: 5,
                  decoration: BoxDecoration(
                      color: const Color(0xFFA5BBB3),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(height: size.height / 55),
                Text(
                  'Remove this budget?',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: size.height / 55),
                Text(
                  'Are you sure do you wanna remove this\n                           budget?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFEFEDED)),
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: Color(0xFF7F3DFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 25,
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFEFEDED)),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: Color(0xFF7F3DFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height / 35),
              ],
            ),
          );
        });
  }
}
