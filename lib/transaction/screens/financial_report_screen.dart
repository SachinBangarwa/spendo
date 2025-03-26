import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';
import 'package:spendo/theme/color_manager.dart';
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

  final TransactionController transactionController=Get.put(TransactionController());
  final List<String> frequencies = [
    'Today',
    'Yesterday',
    'Week',
    'Month',
    'Year'
  ];
  String frequency = 'Year';
  bool isBudget = false;
  bool isExpense = true;
  bool isIncome = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Financial Report',
        onBack: () {
          Get.back();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height / 45),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showFrequencyMenu(context, size),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 40, vertical: 2),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color:Color(0xFFF1F1FA)),
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
                Container(
                  width: size.width / 4,
                  height: size.height / 17,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color(0xFFF1F1FA)),
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
          if (!isBudget) ...[
            SizedBox(height: size.height / 55),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 22),
              child: const Text(
                '\$6000',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
            ),
            const CustomSpendFrequencyChartWidget(),
          ] else
            Padding(
              padding: EdgeInsets.only(top: size.height / 12,bottom: size.height/22),
              child:  CustomPieChartWidget(
               incomeAmount: (transactionController.totalIncome.value).toDouble(),
               expenseAmount: (transactionController.totalExpense.value).toDouble(),
                type:isExpense? 'Expense':'Income',
              ),
            ),
          SizedBox(height: size.height / 18),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Container(
              padding: const EdgeInsets.all(4),
              width: size.width,
              height: size.height / 14,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFF1F1FA),
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
                            : Color(0xFFF1F1FA),
                      ),
                      child: Text(
                        'Expense',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: isExpense ? Colors.white : Colors.black),
                      ),
                    ),
                  )),
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
                            : Color(0xFFF1F1FA),
                      ),
                      child: Text(
                        'Income',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: isIncome ? Colors.white : Colors.black),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height / 25),
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 22),
                    child: CustomLinearProgressBarWidget(
                        // isIncome: isIncome,
                        // isExpense: isExpense,
                        ),
                  )))
        ],
      ),
    );
  }

  void showFrequencyMenu(BuildContext context, Size size) async {
    final String? selectedFreq = await showMenu<String>(
      context: context,
      color: Colors.white,
      shadowColor: const Color(0xffcac0dd),
      position: RelativeRect.fromLTRB(
          size.width / 22, size.height / 10, size.width / 22, 0),
      items: frequencies
          .map((String freq) => PopupMenuItem<String>(
                value: freq,
                child: Text(
                  freq,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ))
          .toList(),
    );

    if (selectedFreq != null) {
      setState(() {
        frequency = selectedFreq;
      });
    }
  }
}

//   Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width / 22),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     showMenu(
//                       shadowColor: const Color(0xffcac0dd),
//                       context: context,
//                       color: Colors.white,
//                       position: RelativeRect.fromLTRB(size.width / 22,
//                           size.height / 1.7, size.width / 22, 0),
//                       items: categories.map((String category) {
//                         return PopupMenuItem<String>(
//                           value: category,
//                           child: Text(
//                             category,
//                             style: const TextStyle(fontWeight: FontWeight.w600),
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.only(
//                         right: size.width / 55,
//                         top: size.height / 230,
//                         bottom: size.height / 230),
//                     decoration: BoxDecoration(
//                         border: Border.all(width: 2, color: Colors.black12),
//                         borderRadius: BorderRadius.circular(20)),
//                     child: const Padding(
//                       padding: EdgeInsets.all(2.0),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.keyboard_arrow_down_sharp,
//                             size: 35,
//                             color: Color(0xff7F3DFF),
//                           ),
//                           Text(
//                             'Transaction',
//                             style: TextStyle(fontWeight: FontWeight.w600),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                       padding: EdgeInsets.all(size.width / 80),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           border:
//                               Border.all(width: 2, color:  Colors.black12),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Icon(
//                         Icons.sort_sharp,
//                         size: 30,
//                       )),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: size.height / 88,
//           ),
