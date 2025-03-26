import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/transaction/screens/financial_report_screen.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class FinancialReportQuoteScreen extends StatelessWidget {
  const FinancialReportQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF7F3DFF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height / 4,
            ),
            const Text(
              "“Financial freedom is freedom from fear.”",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 29,
                height: 0,
              ),
            ),
            SizedBox(
              height: size.height / 120,
            ),
            const Text(
              '-Robert Kiyosaki',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
            const Spacer(),
            CustomButton(
                text: 'See the full Detail',
                colorButton: ColorManager.lightBackground,
                colorText: const Color(0xFF7F3DFF),
                onTap: () {
                  Get.to(()=>const FinancialReportScreen());
                }),
            SizedBox(height: size.height/22,)
          ],
        ),
      ),
    );
  }
}
