import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/home/controllers/financial_report_controller.dart';
import '../home/controllers/transaction_controller.dart';

class CustomSpendFrequencyChartWidget extends StatelessWidget {
  final FinancialReportController controller;
  final bool isIncome;

  CustomSpendFrequencyChartWidget({
    super.key,
    required this.controller,
    required this.isIncome,
  });

  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      double totalAmount = isIncome
          ? transactionController.totalIncome.value
          : transactionController.totalExpense.value ;

      Map<String, double> categoryData = isIncome
          ? controller.categoryIncomeMap
          : controller.categoryExpenseMap;

      List<String> categories = categoryData.keys.toList();
      List<double> amounts = categoryData.values.toList();

      double maxY = totalAmount > 0 ? totalAmount.ceilToDouble() : 10.0;

      List<FlSpot> spots = [];

      if (categories.isNotEmpty) {
        spots.add(FlSpot(-0.5, amounts.first));
      }

      for (int index = 0; index < categories.length; index++) {
        double categoryAmount = amounts[index];
        double yValue = totalAmount > 0
            ? (categoryAmount / totalAmount) * maxY
            : categoryAmount;
        spots.add(FlSpot(index.toDouble(), yValue));
      }

      if (categories.isNotEmpty) {
        spots.add(FlSpot(categories.length - 0.5, amounts.last));
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: size.height / 5,
          width: size.width * 1.2,
          color: Colors.white,
          padding: EdgeInsets.only(
              left: size.width / 99,
              right: size.width / 99,
              bottom: size.height / 99),
          child: LineChart(
            LineChartData(
              backgroundColor: Colors.transparent,
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: -0.4,
              maxX: categories.length.toDouble() - 0.6,
              minY: 0,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: isIncome ? Colors.green : Colors.red,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        (isIncome ? Colors.green : Colors.red).withOpacity(0.5),
                        (isIncome ? Colors.green : Colors.red).withOpacity(0.4),
                        (isIncome ? Colors.green : Colors.red).withOpacity(0.3),
                        (isIncome ? Colors.green : Colors.red).withOpacity(0.2),
                        (isIncome ? Colors.green : Colors.red).withOpacity(0.1),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: const FlDotData(show: true),
                  barWidth: 4,
                  isStrokeCapRound: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
