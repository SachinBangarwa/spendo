import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomPieChartWidget extends StatelessWidget {
  final double amount;

  const CustomPieChartWidget({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double fontSize = calculateFontSize(amount, size.width);

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
                  sections: [
                    PieChartSectionData(
                        value: 66,
                        title: '',
                        radius: size.width / 16,
                        color: Color(0xFFFD3C4A)),
                    PieChartSectionData(
                        value: 200,
                        title: '',
                        radius: size.width / 16,
                        color: Color(0xFFFCAC12)),
                    PieChartSectionData(
                        value: 200,
                        title: '',
                        radius: size.width / 16,
                        color: Color(0xFF7F3DFF)),
                  ]),
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(0)}',  // INR symbol added
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  double calculateFontSize(double amount, double screenWidth) {
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
