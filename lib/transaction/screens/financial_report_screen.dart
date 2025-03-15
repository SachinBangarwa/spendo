import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/custom_spend_frequency_chart_widget.dart';
import 'package:spendo/widgets/custom_transaction_section.dart';

class FinancialReportScreen extends StatefulWidget {
  FinancialReportScreen({super.key});

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  final List<String> categories = [
    "Shopping",
    "Food & Drinks",
    "Transport",
    "Entertainment",
    "Health & Fitness"
  ];
  List<String> frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

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
          SizedBox(
            height: size.height / 45,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showMenu(
                        shadowColor: Color(0xffcac0dd),
                        context: context,
                        color: Colors.white,
                        position: RelativeRect.fromLTRB(size.width / 22,
                            size.height / 10, size.width / 22, 0),
                        items: frequencies
                            .map((String frequencies) => PopupMenuItem(
                                value: frequencies,
                                child: Text(
                                  frequencies,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )))
                            .toList());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        right: size.width / 50, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xffb3a1d4)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 35,
                          color: Color(0xff7F3DFF),
                        ),
                        Text(
                          'Month',
                          style: TextStyle(fontWeight: FontWeight.w600),
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
                      border: Border.all(width: 2, color: Color(0xffcac0dd)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Flexible(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          color: Color(0xFF5508EB),
                        ),
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      )),
                      Flexible(
                          child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          // color: Color(0xFF5508EB),
                        ),
                        child: Image.asset(
                          'assets/icons/budget.png',
                          color: Color(0xFF5508EB),
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Text(
              '\$6000',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
          ),
          CustomSpendFrequencyChartWidget(),
          SizedBox(
            height: size.height / 66,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Container(
              padding: EdgeInsets.all(1.5),
              width: size.width,
              height: size.height / 14,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(width: 2, color: Color(0xffb3a1d4)),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Color(0xFF5508EB),
                    ),
                    child: Text('Expense',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white)),
                  )),
                  Flexible(
                      child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      // color: Color(0xFF5508EB),
                    ),
                    child: Text(
                      'Income',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height / 45,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showMenu(
                      shadowColor: Color(0xffcac0dd),
                      context: context,
                      color: Colors.white,
                      position: RelativeRect.fromLTRB(size.width / 22,
                          size.height / 1.7, size.width / 22, 0),
                      items: categories.map((String category) {
                        return PopupMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        right: size.width / 55,
                        top: size.height / 230,
                        bottom: size.height / 230),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xffcac0dd)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
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
                          )
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
                              Border.all(width: 2, color: Color(0xffcac0dd)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.sort_sharp,
                        size: 30,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height / 88,
          ),
          Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 22),
                    child: CustomTransactionSection(),
                  )))
        ],
      ),
    );
  }
}
