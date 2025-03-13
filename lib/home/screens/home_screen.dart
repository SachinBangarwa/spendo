import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/home/screens/expense_screen.dart';
import 'package:spendo/home/screens/income_screen.dart';
import 'package:spendo/theme/color_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height / 2.7,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(44),
                  bottomLeft: Radius.circular(44),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF6E6),
                    Color(0xFFF8EDD8).withOpacity(0.3),
                  ],
                  stops: [0.0956, 1.0],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height / 25,
                    left: size.width / 22,
                    right: size.width / 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: ColorManager.primary, width: 2),
                          ),
                          child: Container(
                            height: size.height / 9,
                            width: size.width / 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/Dr_ Abdul Kalam.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 35,
                              color: ColorManager.primary,
                            ),
                            Text(
                              'October',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_sharp,
                              size: 35,
                            ))
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(0, -10),
                      child: Text(
                        'Account Balance',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF91919F)),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -10),
                      child: Text(
                        'Rs9400',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: _buildCard(
                              size: size,
                              title: 'Income',
                              amount: 'Rs5000',
                              color: Color(0xFF00A86B),
                              icon: 'assets/icons/Income.png',
                              onTab: () => Get.to(() => IncomeScreen())),
                        ),
                        SizedBox(width: size.width / 30),
                        Flexible(
                          child: _buildCard(
                              size: size,
                              title: 'Expense',
                              amount: 'Rs5000',
                              color: Color(0xFFFD3C4A),
                              icon: 'assets/icons/Income.png',
                              onTab: () => Get.to(() => ExpenseScreen())),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 22, vertical: size.height / 70),
                    child: Text(
                      'Spend Frequency',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SpendFrequencyChart(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 22, vertical: size.width / 111),
                    child: Row(
                      children: List.generate(4, (index) {
                        int selectIndex = 0;
                        List days = [
                          'Today',
                          'Week',
                          'Month',
                          'Year',
                        ];
                        return Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height / 19,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectIndex == index
                                  ? ColorManager.primary.withOpacity(0.2)
                                  : ColorManager.lightBackground,
                            ),
                            child: Text(
                              days[index],
                              style: TextStyle(
                                  color: selectIndex == index
                                      ? ColorManager.primary
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 22, vertical: size.height / 75),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Transaction',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 25,
                              vertical: size.height / 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF8F57FB).withOpacity(0.2),
                          ),
                          child: Text(
                            'See All',
                            style: TextStyle(
                                color: Color(0xFF7F3DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width / 22,
                            vertical: size.height / 150),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width / 35,
                            vertical: size.height / 50),
                        decoration: BoxDecoration(
                          color: Color(0xFFFCFCFC),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: size.height / 16,
                              width: size.height / 16,
                              decoration: BoxDecoration(
                                color: ColorManager.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/icons/profile.png',
                                  width: size.height / 22,
                                  height: size.height / 22,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: size.width / 30),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shopping',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Buy some grocery',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xFF91919F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '- Rs120',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '10:00 AM',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF91919F),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildCard({
    required Size size,
    required String title,
    required String amount,
    required Color color,
    required String icon,
    required VoidCallback onTab,
  }) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: size.height / 10,
        padding: EdgeInsets.symmetric(horizontal: size.width / 30),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height / 17,
              width: size.height / 17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                  padding: EdgeInsets.all(size.width / 34),
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                    color: color,
                  )),
            ),
            SizedBox(
              width: size.width / 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SpendFrequencyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 5,
      color: Colors.white,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.transparent,
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 8,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 2),
                FlSpot(1, 1),
                FlSpot(2, 3),
                FlSpot(3, 2),
                FlSpot(4, 5),
                FlSpot(5, 4),
                FlSpot(6, 8),
              ],
              isCurved: true,
              color: Color(0xFF7F3DFF),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF7F3DFF).withOpacity(0.3),
                    Color(0xFF7F3DFF).withOpacity(0.2),
                    Color(0xFF7F3DFF).withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: false),
              barWidth: 4,
              isStrokeCapRound: true,
            ),
          ],
        ),
      ),
    );
  }
}
