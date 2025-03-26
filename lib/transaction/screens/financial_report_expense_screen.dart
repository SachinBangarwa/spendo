import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';

class FinancialReportExpenseScreen extends StatefulWidget {
  const FinancialReportExpenseScreen({super.key});

  @override
  State<FinancialReportExpenseScreen> createState() =>
      _FinancialReportExpenseScreenState();
}

class _FinancialReportExpenseScreenState
    extends State<FinancialReportExpenseScreen> {
  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFD3C4A),
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
            ),
          ),
          SizedBox(height: size.height / 8),
          const Text(
            'You Spend💸',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Obx(
            () {
              double totalSpent = transactionController.totalExpense.value;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 22),
                child: Text(
                  '₹${totalSpent.toString()}',
                  style: TextStyle(
                    height: 0,
                    fontSize: getDynamicFontSize(totalSpent),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: size.width / 22, vertical: size.height / 22),
            padding: EdgeInsets.all(size.height / 45),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                const Text(
                  'and your biggest \nspending is from',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height / 66),
                Obx(
                  () {
                    double biggestAmount =
                        transactionController.biggestExpenseAmount.value;
                    String category =
                        transactionController.biggestExpenseCategory.value;

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: size.height / 77),
                          margin:
                              EdgeInsets.symmetric(horizontal: size.width / 8),
                          decoration: BoxDecoration(
                            color: category == "Transfer"
                                ? Colors.blueAccent
                                : const Color(0xFFE3E5E5),
                            border: Border.all(
                                color: const Color(0xffcac0dd), width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                category == "Transfer"
                                    ? Icons.sync_alt
                                    : Icons.shopping_cart_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(width: size.width / 77),
                              Flexible(
                                child: Text(
                                  category.isNotEmpty ? category : "N/A",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: category == "Transfer"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height / 180),
                        Text(
                          '₹${biggestAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: biggestAmount > 9999 ? 28 : 36,
                            fontWeight: FontWeight.bold,
                            color: category == "Transfer"
                                ? Colors.blueAccent
                                : Colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
      return 45;
    }
  }
}
