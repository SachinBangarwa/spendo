import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';
import '../home/controllers/home_transaction_controller.dart';

class CommonChartHomeScreenWidget extends StatelessWidget {
  final HomeTransactionController controller =
      Get.put(HomeTransactionController());
  final TransactionController transactionController =
      Get.put(TransactionController());

  CommonChartHomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (controller.transactionsList.isEmpty) {
        return Container(
          height: size.height / 6,
          alignment: Alignment.center,
          child: const Text(
            "No data available",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        );
      }

      double maxY = (transactionController.totalIncome.value +
              transactionController.totalExpense.value +
              transactionController.totalTransfer.value)
          .ceilToDouble();
      maxY = maxY > 0 ? maxY : 10.0;

      return Container(
        margin: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7F3DFF).withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: size.width * 1.1,
            height: size.height / 5,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height / 55),
              child: LineChart(
                LineChartData(
                  backgroundColor: Colors.transparent,
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: -0.4,
                  maxX: controller.transactionsList.length.toDouble() - 0.6,
                  minY: 0,
                  maxY: maxY,
                  lineBarsData: [
                    _buildLineChartBarData(
                        transactionController.totalIncome.value),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  LineChartBarData _buildLineChartBarData(double totalAmount) {
    List<FlSpot> spots = [];
    for (int i = 0; i < controller.transactionsList.length; i++) {
      double value = controller.transactionsList[i]['amount'] ?? 0.0;
      spots.add(FlSpot(i.toDouble(), value));
    }

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: const Color(0xFF7F3DFF),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7F3DFF).withOpacity(0.4),
            const Color(0xFF7F3DFF).withOpacity(0.3),
            const Color(0xFF7F3DFF).withOpacity(0.2),
            const Color(0xFF7F3DFF).withOpacity(0.1),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      dotData: const FlDotData(show: true),
      barWidth: 3.5,
      isStrokeCapRound: true,
    );
  }
}
