import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendo/home/controllers/financial_report_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/transaction/screens/detail_transaction_screen.dart';
import 'package:spendo/widgets/custom_linear_progress_bar_widget.dart';
import 'package:spendo/widgets/custom_pie_chart_widget.dart';
import 'package:spendo/widgets/custom_spend_frequency_chart_widget.dart';
import '../../widgets/common_appBar _widget.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({super.key});

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  final FinancialReportController controller =
      Get.put(FinancialReportController());

  bool isBudget = false;
  bool isExpense = false;
  bool isIncome = true;
  final List<String> categories = [
    "Salary",
    "Freelance",
    "Investments",
    "Gifts",
    "Business",
    "Shopping",
    "Food & Drinks",
    "Transport",
    "Entertainment",
    "Health & Fitness"
  ];



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Financial Report',
        backGroundCol: ColorManager.lightBackground,
        onBack: () {
          Get.back();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Frequency Menu
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showFrequencyMenu(context, size);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        right: size.width / 40, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: const Color(0xFFF1F1FA)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        const Icon(Icons.keyboard_arrow_down_sharp,
                            size: 35, color: Color(0xff7F3DFF)),
                        Obx(() => Text(controller.frequency.value,
                            style: const TextStyle(fontWeight: FontWeight.w600)))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: size.width / 4,
                  height: size.height / 17,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: const Color(0xFFF1F1FA)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Flexible(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isBudget = !isBudget;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            color: isBudget
                                ? Colors.white
                                : const Color(0xFF5508EB),
                          ),
                          child: Icon(
                            Icons.share,
                            color: isBudget
                                ? const Color(0xFF5508EB)
                                : Colors.white,
                          ),
                        ),
                      )),
                      Flexible(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isBudget = !isBudget;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isBudget
                                ? const Color(0xFF5508EB)
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Image.asset(
                            'assets/icons/budget.png',
                            color: isBudget
                                ? Colors.white
                                : const Color(0xFF5508EB),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (!isBudget)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height / 55),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 22),
                  child: const Text('\$6000',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                ),
                 CustomSpendFrequencyChartWidget(isIncome: isIncome,controller: controller,),
                SizedBox(height: size.height/35,),
              ],
            )
          else
            Padding(
                padding: EdgeInsets.only(
                    top: size.height / 10, bottom: size.height / 10),
                child: CustomPieChartWidget(
                  type: isIncome ? "Income" : "Expense",
                )),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22,),
            child: Container(
              padding: const EdgeInsets.all(1.5),
              width: size.width,
              height: size.height / 14,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xFFF1F1FA),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpense = true;
                          isIncome = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: isExpense
                              ? const Color(0xFF5508EB)
                              : const Color(0xFFF1F1FA),
                        ),
                        child: Text(
                          'Expense',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: isExpense ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isIncome = true;
                          isExpense = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: isIncome
                              ? const Color(0xFF5508EB)
                              : const Color(0xFFF1F1FA),
                        ),
                        child: Text(
                          'Income',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: isIncome ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
            SizedBox(height: size.height/35,),
            Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showMenu(
                      shadowColor: const Color(0xffcac0dd),
                      context: context,
                      color: Colors.white,
                      position: RelativeRect.fromLTRB(size.width / 22,
                          size.height / 1.7, size.width / 22, 0),
                      items: categories.map((String category) {
                        return PopupMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color:  const Color(0xFFF1F1FA)),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 35,
                            color: Color(0xff7F3DFF),
                          ),
                          Text(
                            'Transaction',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 2,)
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(size.width / 80),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color:   const Color(0xFFF1F1FA)),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.sort_sharp,
                        size: 30,
                      )),
                ),
              ],
            ),
          ),

          if (!isBudget) ...[
            SizedBox(
              height: size.height / 30,
            ),
            Obx(() {
              if (controller.expenseList.isEmpty ||
                  controller.incomeList.isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: size.height / 10),
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
                );
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    child: buildTransactionData(size, isIncome),
                  ),
                );
              }
            }),
          ] else
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width / 22, vertical: size.height / 35),
                  child: CustomLinearProgressBarWidget(
                    isIncome: isIncome,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildTransactionData(
    Size size,
    bool isIncome,
  ) {
    List dataList = isIncome ? controller.incomeList : controller.expenseList;

   return ListView.builder(
     padding: EdgeInsets.only(bottom: size.height / 14),
     shrinkWrap: true,
     physics: const NeverScrollableScrollPhysics(),
     itemCount: dataList.length,
     itemBuilder: (context, index) {
       Map<String, dynamic> data = dataList[index];

       String formattedAmount = '${data['amount'] ?? '0'}';
       DateTime dateTime = DateTime.parse(data['date']);
       String formattedTime = DateFormat.jm().format(dateTime);

       bool isNegative =
           data['type'] == 'Expense' || data['type'] == 'Transfer';
       Color amountColor = isNegative
           ? const Color(0xFFFD3C4A) // Expense Color
           : const Color(0xFF00A86B); // Income Color

       return GestureDetector(
         onTap: () {
           Get.to(() => DetailTransactionScreen(data: data));
         },
         child: Container(
           margin: EdgeInsets.symmetric(
               horizontal: size.width / 22, vertical: size.height / 150),
           padding: EdgeInsets.symmetric(
               horizontal: size.width / 35, vertical: size.height / 50),
           decoration: BoxDecoration(
             color: const Color(0xFFFAFAFA),
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
                       data['category'].isEmpty
                           ? 'Transfer'
                           : data['category'],
                       style: const TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.w600,
                           color: Colors.black87),
                     ),
                     const SizedBox(height: 4),
                     Text(
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       data['description'].isEmpty
                           ? 'Buy some grocery'
                           : data['description'],
                       style: const TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 13,
                           color: Color(0xFF91919F)),
                     ),
                   ],
                 ),
               ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Text(
                     isNegative ? '-₹$formattedAmount' : "₹$formattedAmount",
                     style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: amountColor),
                   ),
                   const SizedBox(height: 4),
                   Text(
                     formattedTime,
                     style: const TextStyle(
                         fontSize: 13,
                         fontWeight: FontWeight.w600,
                         color: Color(0xFF91919F)),
                   ),
                 ],
               ),
             ],
           ),
         ),
       );
     },
   );
  }

  void showFrequencyMenu(BuildContext context, Size size) async {
    final String? selectedFreq = await showMenu<String>(
      context: context,
      color: Colors.white,
      shadowColor: const Color(0xffcac0dd),
      position: RelativeRect.fromLTRB(
          size.width / 22, size.height / 10, size.width / 22, 0),
      items: ['Today', 'Yesterday', 'Week', 'Month', 'Year']
          .map((String freq) => PopupMenuItem<String>(
                value: freq,
                child: Text(freq,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ))
          .toList(),
    );
    controller.updateFrequency(selectedFreq ?? 'Year');
  }
}

