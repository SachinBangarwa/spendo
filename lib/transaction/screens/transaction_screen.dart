import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/transaction/screens/report_screen.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../widgets/custom_transaction_section.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

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
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(right: size.width / 55),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xffcac0dd)),
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
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (index) {
                            return Container(
                              height: size.height/1.5,
                              width: size.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 22),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30))),
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
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ),
                                  SizedBox(height: size.height / 55),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Filter Transaction',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width / 35,
                                            vertical: size.height / 150),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffEEE5FF),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          'Reset',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff7F3DFF)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height / 55),
                                  Text(
                                    'Filter By',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
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
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width / 22,
                                            vertical: size.height / 99),
                                        margin: EdgeInsets.only(
                                            right: size.width / 45),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Color(0xffcac0dd)),
                                          borderRadius:
                                              BorderRadius.circular(20),

                                          //  color: Color(0xFFA5BBB3)
                                        ),
                                        child: Text(
                                          type[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1b1919)),
                                        ),
                                      ),
                                    );
                                  })),
                                  SizedBox(height: size.height / 55),
                                  Text(
                                    'Sort By',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: size.height / 55),
                                  Wrap(
                                      children: List.generate(4, (index) {
                                    List<String> type = [
                                      'Highest',
                                      'Lowest',
                                      'Newest',
                                      'Oldest'
                                    ];
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width / 22,
                                            vertical: size.height / 99),
                                        margin: EdgeInsets.only(
                                            right: size.width / 45,
                                            bottom: size.height / 65),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Color(0xffcac0dd)),
                                          borderRadius:
                                              BorderRadius.circular(20),

                                          //  color: Color(0xFFA5BBB3)
                                        ),
                                        child: Text(
                                          type[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff1b1919)),
                                        ),
                                      ),
                                    );
                                  })),
                                  Text(
                                    'Category',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(height: size.height / 55),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Choses Category',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '0 Selected',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Icon(Icons.arrow_forward_ios_sharp,color: Color(0xff7F3DFF),)
                                        ],
                                      )
                                    ],
                                  ),
                                Spacer(),

                                  CustomButton(text: 'Apply', colorButton:  Color(0xff7F3DFF), colorText: ColorManager.lightBackground, onTap: (){})
                               ,   SizedBox(height: size.height / 35), ],
                              ),
                            );
                          });
                    },
                    child: Container(
                        padding: EdgeInsets.all(size.width / 100),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: Color(0xffcac0dd)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
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
                onTap: (){
                  Get.to(()=>ReportScreen());
                },
                child: Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: size.width / 22,vertical: size.height/95),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffEEE5FF)),
                  child: Row(
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
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: size.height / 75,
                      ),
                      CustomTransactionSection(),
                      SizedBox(
                        height: size.height / 75,
                      ),
                      const Text(
                        'Yesterday',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: size.height / 75,
                      ),
                      CustomTransactionSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
