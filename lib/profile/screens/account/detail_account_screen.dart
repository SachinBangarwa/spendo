import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendo/profile/controllers/get_account_transaction_controller.dart';
import 'package:spendo/profile/screens/account/edit_bank_screen.dart';
import 'package:spendo/profile/screens/account/edit_wallet_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/transaction/screens/detail_transaction_screen.dart';
import 'package:spendo/widgets/common_app_bar%20_widget.dart';

class DetailAccountScreen extends StatefulWidget {
  const DetailAccountScreen({super.key, required this.account});

  final Map<String, dynamic> account;

  @override
  State<DetailAccountScreen> createState() => _DetailAccountScreenState();
}

class _DetailAccountScreenState extends State<DetailAccountScreen> {
  final GetAccountTransactionController _controller =
      Get.put(GetAccountTransactionController());

  @override
  void initState() {
    super.initState();
    _controller.getAccountTransactions(widget.account['name']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Detail Account',
        backGroundCol: ColorManager.lightBackground,
        trailing: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 22),
          child: const Icon(
            Icons.mode_edit_outline_outlined,
            size: 26,
          ),
        ),
        onBack: () {
          Get.back();
        },
        onTrailingTap: () {
          if (widget.account['type'] == "Wallet") {
            Get.to(() => EditWalletScreen(
                  account: widget.account,
                ));
          } else {
            Get.to(() => EditBankScreen(
                  account: widget.account,
                ));
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height / 18, horizontal: size.width / 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.account['name'] ?? 'Unknown',
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, height: 0)),
            SizedBox(height: size.height / 88),
            Text('₹${widget.account['balance'] ?? 0.0}',
                style: const TextStyle(
                    fontSize: 32, fontWeight: FontWeight.w700, height: 0)),
            Divider(
              height: size.height / 20,
              color: Colors.black12.withOpacity(0.1),
            ),
            SizedBox(height: size.height / 40),
            Expanded(
              child: Obx(() {
                if (_controller.transactionsList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No transactions available',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                Map<String, List<Map<String, dynamic>>>
                    categorizedTransactions = categorizeTransactions(_controller
                        .transactionsList
                        .toList()
                        .cast<Map<String, dynamic>>());

                return ListView(
                  padding: EdgeInsets.only(bottom: size.height / 20),
                  children: categorizedTransactions.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height / 60,
                              horizontal: size.width / 30),
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Column(
                          children: entry.value.map((data) {
                            String formattedAmount = '${data['amount'] ?? '0'}';
                            String formattedTime = DateFormat.jm()
                                .format(DateTime.parse(data['date']));
                            bool isNegative = (data['type'] == 'Expense' ||
                                data['type'] == 'Transfer');
                            Color amountColor =
                                isNegative ? Colors.red : Colors.green;

                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => DetailTransactionScreen(data: data));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: size.height / 150),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 35,
                                    vertical: size.height / 50),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAFAFA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: size.height / 16,
                                      width: size.height / 16,
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary
                                            .withOpacity(0.2),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['category'] == ''
                                                ? 'Transfer'
                                                : data['category'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            data['description'] == ''
                                                ? 'Buy some grocery'
                                                : data['description'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xFF91919F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          isNegative
                                              ? '-₹$formattedAmount'
                                              : "₹$formattedAmount",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: amountColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formattedTime,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF91919F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> categorizeTransactions(
      List<Map<String, dynamic>> transactions) {
    Map<String, List<Map<String, dynamic>>> categorizedTransactions = {};

    for (var transaction in transactions) {
      DateTime date = DateTime.parse(transaction['date']);
      String category = getTransactionHeader(date);

      if (!categorizedTransactions.containsKey(category)) {
        categorizedTransactions[category] = [];
      }

      categorizedTransactions[category]!.add(transaction);
    }
    return categorizedTransactions;
  }

  String getTransactionHeader(DateTime date) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime weekAgo = today.subtract(const Duration(days: 7));

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return "Yesterday";
    } else if (date.isAfter(weekAgo)) {
      return "This Week";
    } else if (date.year == now.year && date.month == now.month) {
      return "This Month";
    } else if (date.year == now.year) {
      return "This Year";
    } else {
      return DateFormat.yMMM().format(date);
    }
  }
}
