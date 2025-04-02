import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:spendo/budget/screens/create_budget_screen.dart';
import 'package:spendo/budget/screens/detail_budget_screen.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final transactionController = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF7F3DFF),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
            left: size.width / 22,
            right: size.width / 22,
            bottom: size.height / 22),
        child: CustomButton(
          text: 'Create a Budget',
          onTap: () {
            Get.to(() => const CreateBudgetScreen());
          },
          colorButton: const Color(0xFF7F3DFF),
          colorText: ColorManager.lightBackground,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 26, vertical: size.height / 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios,
                          color: ColorManager.lightBackground, size: 22)),
                  Text(
                    DateFormat.MMMM().format(DateTime.now()),
                    style: const TextStyle(
                        color: ColorManager.lightBackground,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: ColorManager.lightBackground, size: 22)),
                ],
              ),
            ),
            // 🔹 Budget List
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 22, vertical: size.height / 99),
                width: size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .collection('budgets')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text("No budgets found!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              )));
                    }
                    var budgets = snapshot.data!.docs;

                    return ListView.builder(
                      padding: EdgeInsets.only(
                          top: size.height / 66, bottom: size.height / 5.6),
                      itemCount: budgets.length,
                      itemBuilder: (context, index) {
                        var budget = budgets[index];
                        double amount = budget['amount'];
                        String category = budget['category'];
                        String id = budget['budgetId'];
                        Color categoryColor =
                            ColorManager.getCategoryColor(category);

                        double spent = transactionController.transactionsList
                            .where((txn) =>
                                txn['category'] == category &&
                                txn['type'] == 'Expense')
                            .fold(0.0, (sum, txn) => sum + txn['amount']);

                        double progress = spent / amount;
                        double remaining = amount - spent;

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => DetailBudgetScreen(
                                  category: category,
                                  budgetId: id,
                                  amount: amount,
                                  spent: spent,
                                  categoryColor: categoryColor,
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.height / 55),
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width / 45,
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 2,
                                              color: const Color(0xFFF1F1FA)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: size.width / 25,
                                            height: size.height / 25,
                                            decoration: BoxDecoration(
                                              color: categoryColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: size.width / 55),
                                          Text(
                                            category,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (spent > amount)
                                      const Icon(Icons.error,
                                          color: Color(0xFFFD3C4A), size: 30)
                                  ],
                                ),
                                Text(
                                  'Remaining ₹${remaining.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: remaining < 0
                                          ? const Color(0xFFFD3C4A)
                                          : Colors.black),
                                ),
                                SizedBox(height: size.height / 99),
                                LinearProgressIndicator(
                                  value: progress.clamp(0.0, 1.0),
                                  minHeight: size.height / 66,
                                  borderRadius: BorderRadius.circular(20),
                                  backgroundColor: Colors.grey[300],
                                  valueColor:
                                      AlwaysStoppedAnimation(categoryColor),
                                ),
                                SizedBox(height: size.height / 99),
                                Text(
                                  '₹$spent of ₹$amount',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                                if (spent > amount)
                                  const Text(
                                    'You’ve exceeded the limit!',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFFFD3C4A),
                                        fontWeight: FontWeight.w500),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
