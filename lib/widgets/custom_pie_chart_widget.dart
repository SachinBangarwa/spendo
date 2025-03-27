import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:spendo/home/controllers/financial_report_controller.dart';
import 'package:spendo/theme/color_manager.dart';

class CustomPieChartWidget extends StatelessWidget {
  final String type;
  final FinancialReportController controller =
      Get.find();

  CustomPieChartWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      final List data =
          type == "Expense" ? controller.expenseList : controller.incomeList;

      double totalAmount =
          data.fold(0.0, (sum, item) => sum + (item['amount'] ?? 0));

      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: size.height / 8,
              width: size.height / 10,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: size.width / 5,
                  sectionsSpace: 0,
                  sections: _generatePieChartSections(data, totalAmount,size),
                ),
              ),
            ),
            Text(
              '₹${totalAmount.toStringAsFixed(0)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _calculateFontSize(totalAmount, size.width),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<PieChartSectionData> _generatePieChartSections(
      List data, double totalAmount,Size size) {
    return data.map((item) {
      double percentage =
          totalAmount == 0 ? 0 : (item['amount'] / totalAmount) * 100;

      return PieChartSectionData(
        value: percentage,
        title: '',
        radius: size.width / 16,
        color: ColorManager.getCategoryColor(item['category']),
      );
    }).toList();
  }



  double _calculateFontSize(double amount, double screenWidth) {
    if (amount >= 100000) {
      return screenWidth / 20;
    } else if (amount >= 10000) {
      return screenWidth / 18;
    } else if (amount >= 1000) {
      return screenWidth / 15;
    } else {
      return screenWidth / 12;
    }
  }
}
