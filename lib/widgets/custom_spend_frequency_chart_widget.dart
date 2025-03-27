import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/home/controllers/financial_report_controller.dart';

class CustomSpendFrequencyChartWidget extends StatelessWidget {
  final FinancialReportController controller;
  final bool isIncome;

  const CustomSpendFrequencyChartWidget({
    super.key,
    required this.controller,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      // ✅ Category-wise total निकालना
      Map<String, double> categoryData =
      isIncome ? controller.categoryIncomeMap : controller.categoryExpenseMap;

      List<String> categories = categoryData.keys.toList();
      List<double> amounts = categoryData.values.toList();

      // ✅ अगर transactions हैं तो max amount निकालो, नहीं तो default 10 रखो
      double maxY = amounts.isNotEmpty ? amounts.reduce((a, b) => a > b ? a : b) : 10.0;

      return Container(
        height: size.height / 5,
        color: Colors.white,
        child: LineChart(
          LineChartData(
            backgroundColor: Colors.transparent,
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: categories.length.toDouble() - 1,
            minY: 0,
            maxY: maxY,
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  categories.length,
                      (index) => FlSpot(index.toDouble(), amounts[index]),
                ),
                isCurved: true,
                color: isIncome ? Colors.green : Colors.red,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      (isIncome ? Colors.green : Colors.red).withOpacity(0.3),
                      (isIncome ? Colors.green : Colors.red).withOpacity(0.2),
                      (isIncome ? Colors.green : Colors.red).withOpacity(0.1),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                dotData: const FlDotData(show: false),
                barWidth: 4,
                isStrokeCapRound: true,
              ),
            ],
          ),
        ),
      );
    });
  }
}
