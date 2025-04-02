import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';

class FinancialReportIncomeScreen extends StatelessWidget {
  const FinancialReportIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TransactionController transactionController =
        Get.put(TransactionController());

    return Scaffold(
      backgroundColor: const Color(0xFF00A86B),
      body: Column(
        children: [
          SizedBox(height: size.height / 6),
          const Center(
              child: Text(
            "This Month",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(height: size.height / 8),
          const Text(
            'You Earned💰',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          // **Dynamic Income Amount**
          Obx(() {
            double totalIncome = transactionController.totalIncome.value;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 22),
              child: Text(
                '₹${totalIncome.toStringAsFixed(2)}',
                maxLines: 1,
                style: TextStyle(
                  height: 0,
                  fontSize: getDynamicFontSize(totalIncome),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            );
          }),

          const Spacer(),

          Container(
            margin: EdgeInsets.only(
                left: size.width / 22,
                right: size.width / 22,
                bottom: size.height / 22),
            padding: EdgeInsets.all(size.height / 45),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your biggest\n Income is from',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700, height: 1.2),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height / 66),
                Obx(() {
                  double biggestIncome =
                      transactionController.biggestIncomeAmount.value;
                  String category =
                      transactionController.biggestIncomeCategory.value;

                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: size.height / 77),
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width / 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3E5E5),
                          border: Border.all(
                              color: const Color(0xffcac0dd), width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.monetization_on,
                                color: Colors.black),
                            SizedBox(width: size.width / 77),
                            Flexible(
                              child: Text(
                                category.isNotEmpty ? category : "N/A",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height / 180),
                      Text(
                        '₹${biggestIncome.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: biggestIncome > 9999 ? 28 : 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  double getDynamicFontSize(double amount) {
    if (amount > 999999) {
      return 32;
    } else if (amount > 99999) {
      return 40;
    } else {
      return 60;
    }
  }
}
