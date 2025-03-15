import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomSpendFrequencyChartWidget extends StatelessWidget {
  const CustomSpendFrequencyChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          maxX: 6,
          minY: 0,
          maxY: 8,
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 2),
                const FlSpot(1, 1),
                const FlSpot(2, 3),
                const FlSpot(3, 2),
                const FlSpot(4, 5),
                const FlSpot(5, 4),
                const FlSpot(6, 8),
              ],
              isCurved: true,
              color: const Color(0xFF7F3DFF),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF7F3DFF).withOpacity(0.3),
                    const Color(0xFF7F3DFF).withOpacity(0.2),
                    const Color(0xFF7F3DFF).withOpacity(0.1),
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
  }
}
