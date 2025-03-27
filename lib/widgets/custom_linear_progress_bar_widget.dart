import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/home/controllers/financial_report_controller.dart';

class CustomLinearProgressBarWidget extends StatelessWidget {
  final bool isIncome;
  final FinancialReportController controller = Get.find();

  CustomLinearProgressBarWidget({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      List data = isIncome ? controller.incomeList : controller.expenseList;

      double maxAmount = data.isNotEmpty
          ? data.map((item) => item['amount']).reduce((a, b) => a + b)
          : 1000;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          double progress = (data[index]['amount'] / maxAmount).clamp(0.0, 1.0);
          Color categoryColor =
              ColorManager.getCategoryColor(data[index]['category']);

          return Padding(
            padding: EdgeInsets.symmetric(vertical: size.height / 77),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width / 45, vertical: 2),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFCFCFC),
                          border: Border.all(
                              width: 2, color: const Color(0xFFF1F1FA)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 25,
                            height: size.height / 25,
                            decoration: BoxDecoration(
                              color: categoryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: size.width / 55),
                          Text(
                            data[index]['category'],
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '₹${data[index]['amount']}',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                SizedBox(height: size.height / 99),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: size.height / 66,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: const Color(0xFFF1F1FA),
                  valueColor: AlwaysStoppedAnimation(categoryColor),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
