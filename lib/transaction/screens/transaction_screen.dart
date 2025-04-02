import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/transaction/screens/detail_transaction_screen.dart';
import 'package:spendo/transaction/screens/report_screen.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late final TransactionController transactionController =
      Get.put(TransactionController());

  List<String> frequencies = ['Today', 'Yesterday', 'Week', 'Month', 'Year'];

  String selectedTransactionType = 'Income';
  String? selectedCategory;
  String sortBy = "'Highest'";

  final List<String> incomeCategories = [
    "Salary",
    "Freelance",
    "Investments",
    "Gifts",
    "Business"
  ];

  final List<String> expenseCategories = [
    "Shopping",
    "Food & Drinks",
    "Transport",
    "Entertainment",
    "Health & Fitness"
  ];

  String frequency = 'Year';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorManager.lightBackground,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height / 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showMenu(
                        shadowColor: const Color(0xffcac0dd),
                        context: context,
                        color: Colors.white,
                        position: RelativeRect.fromLTRB(size.width / 22,
                            size.height / 14, size.width / 22, 0),
                        items: frequencies.map((String freq) {
                          return PopupMenuItem(
                            value: freq,
                            child: Text(
                              freq,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              setState(() {
                                frequency = freq;
                              });
                              transactionController
                                  .fetchFilteredTransactions(freq);
                            },
                          );
                        }).toList(),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          right: size.width / 40, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: const Color(0xffcac0dd)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 25,
                            color: Color(0xff7F3DFF),
                          ),
                          Text(
                            frequency,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return buildBottomSheetFilter(size);
                        },
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(size.width / 100),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(0xffcac0dd)),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.sort_sharp,
                          size: 24,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ReportScreen());
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 22, vertical: size.height / 95),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffEEE5FF)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'See your financial report',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7F3DFF)),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xff7F3DFF),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Obx(
                    () {
                      Map<String, List<Map<String, dynamic>>>
                          categorizedTransactions = {};

                      for (var transaction
                          in transactionController.transactionsList) {
                        DateTime date = DateTime.parse(transaction['date']);
                        String category = getTransactionHeader(date);

                        if (!categorizedTransactions.containsKey(category)) {
                          categorizedTransactions[category] = [];
                        }
                        categorizedTransactions[category]!.add(transaction);
                      }

                      return transactionController.transactionsList.isEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: size.height / 4),
                              child: const Center(
                                child: Text(
                                  'No transactions available',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children:
                                  categorizedTransactions.entries.map((entry) {
                                String category = entry.key;
                                List<Map<String, dynamic>> transactions =
                                    entry.value;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width / 120,
                                          vertical: size.height / 120),
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.only(
                                          bottom: size.height / 20),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: transactions.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> data =
                                            transactions[index];

                                        String formattedAmount =
                                            '${data['amount'] ?? '0'}';
                                        String formattedTime = DateFormat.jm()
                                            .format(
                                                DateTime.parse(data['date']));

                                        bool isNegative =
                                            (data['type'] == 'Expense' ||
                                                data['type'] == 'Transfer');
                                        Color amountColor = isNegative
                                            ? Colors.red
                                            : Colors.green;

                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(() =>
                                                DetailTransactionScreen(
                                                    data: data));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: size.height / 150),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width / 35,
                                                vertical: size.height / 50),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFAFAFA),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: size.height / 16,
                                                  width: size.height / 16,
                                                  decoration: BoxDecoration(
                                                    color: ColorManager.primary
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
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
                                                SizedBox(
                                                    width: size.width / 30),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data['category'] == ''
                                                            ? 'Transfer'
                                                            : data['category'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        data['description'] ==
                                                                ''
                                                            ? 'Buy some grocery'
                                                            : data[
                                                                'description'],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xFF91919F),
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: amountColor,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      formattedTime,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF91919F),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }).toList(),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  StatefulBuilder buildBottomSheetFilter(Size size) {
    return StatefulBuilder(builder: (context, setModalState) {
      return Container(
        height: selectedTransactionType == 'Transfer'
            ? size.height / 1.8
            : size.height / 1.5,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: size.width / 22),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Container(
                margin: const EdgeInsets.all(6),
                width: size.width / 8,
                height: 5,
                decoration: BoxDecoration(
                    color: const Color(0xffddcef8),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: size.height / 55),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Transaction',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 35, vertical: size.height / 150),
                  decoration: BoxDecoration(
                      color: const Color(0xffEEE5FF),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Color(0xff7F3DFF)),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height / 55),
            const Text(
              'Filter By',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: size.height / 55),
            Row(
                children: List.generate(3, (index) {
              List<String> type = [
                'Income',
                'Expense',
                'Transfer',
              ];
              return GestureDetector(
                onTap: () {
                  setModalState(() {
                    selectedTransactionType = type[index];
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 22, vertical: size.height / 99),
                  margin: EdgeInsets.only(right: size.width / 45),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: selectedTransactionType == type[index]
                              ? const Color(0xffEEE5FF)
                              : const Color(0xffcac0dd)),
                      borderRadius: BorderRadius.circular(20),
                      color: selectedTransactionType == type[index]
                          ? const Color(0xffEEE5FF)
                          : const Color(0xFFFFFFFF)
                      //  color: Color(0xFFA5BBB3)
                      ),
                  child: Text(
                    type[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selectedTransactionType == type[index]
                            ? const Color(0xffa986ed)
                            : const Color(0xff1b1919)),
                  ),
                ),
              );
            })),
            SizedBox(height: size.height / 55),
            const Text(
              'Sort By',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: size.height / 55),
            Wrap(
                children: List.generate(4, (index) {
              List<String> type = ['Highest', 'Lowest', 'Newest', 'Oldest'];
              return GestureDetector(
                onTap: () {
                  setModalState(() {
                    sortBy = type[index];
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 22, vertical: size.height / 99),
                  margin: EdgeInsets.only(
                      right: size.width / 45, bottom: size.height / 65),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: sortBy == type[index]
                              ? const Color(0xffEEE5FF)
                              : const Color(0xffcac0dd)),
                      borderRadius: BorderRadius.circular(20),
                      color: sortBy == type[index]
                          ? const Color(0xffEEE5FF)
                          : const Color(0xFFFFFFFF)),
                  child: Text(
                    type[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: sortBy == type[index]
                            ? const Color(0xffa986ed)
                            : const Color(0xff1b1919)),
                  ),
                ),
              );
            })),
            if (selectedTransactionType != 'Transfer') ...[
              const Text(
                'Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: size.height / 55),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Choose Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      showMenu(
                        shadowColor: const Color(0xffcac0dd),
                        context: context,
                        color: Colors.white,
                        position: RelativeRect.fromLTRB(
                          size.width / 10,
                          size.height / 2,
                          size.width / 22,
                          size.width / 22,
                        ),
                        items: selectedTransactionType == 'Income'
                            ? incomeCategories.map((String category) {
                                return PopupMenuItem(
                                  value: category,
                                  child: Text(
                                    category,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () {
                                    setModalState(() {
                                      selectedCategory = category;
                                    });
                                  },
                                );
                              }).toList()
                            : expenseCategories.map((String category) {
                                return PopupMenuItem(
                                  value: category,
                                  child: Text(
                                    category,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () {
                                    setModalState(() {
                                      selectedCategory = category;
                                    });
                                  },
                                );
                              }).toList(),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          'Selected',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color(0xff7F3DFF),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
            const Spacer(),
            CustomButton(
                text: 'Apply',
                colorButton: const Color(0xff7F3DFF),
                colorText: ColorManager.lightBackground,
                onTap: () {
                  transactionController.fetchFilterTransaction(
                      selectedCategory ?? '', selectedTransactionType, sortBy);
                  Get.back();
                }),
            SizedBox(height: size.height / 35),
          ],
        ),
      );
    });
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
      return "Week";
    } else if (date.year == now.year && date.month == now.month) {
      return "Month";
    } else if (date.year == now.year) {
      return "Year";
    } else {
      return DateFormat.yMMM().format(date); // Older transactions
    }
  }
}
