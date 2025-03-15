import 'package:flutter/material.dart';
import 'package:spendo/transaction/screens/financial_report_budget_screen.dart';
import 'package:spendo/transaction/screens/financial_report_expense_screen.dart';
import 'package:spendo/transaction/screens/financial_report_income_screen.dart';
import 'package:spendo/transaction/screens/financial_report_quote_screen.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;

  List<Widget> list = [
    FinancialReportExpenseScreen(),
    FinancialReportIncomeScreen(),
    FinancialReportBudgetScreen(),
    FinancialReportQuoteScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            children: list,
          ),


          Positioned(
            top: size.height/55,
            left: size.width/25,
            right: size.width/25,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: size.height/16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  list.length,
                      (index) => buildIndicator(size,index == currentPageIndex),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(Size size,bool isActive) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(3),
        height: size.height/180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: isActive ? Colors.white :
          Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}