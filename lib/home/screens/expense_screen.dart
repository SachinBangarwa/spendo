import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/common_drop_down_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../commons/common_styles.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final TextEditingController descController = TextEditingController();

  bool checkBox = false;
  String selectedCategory = 'Shopping';
  String selectedWallet = 'Cash';
  List<String> categories = [
    "Shopping",
    "Food & Drinks",
    "Transport",
    "Entertainment",
    "Health & Fitness"
  ];
  List<String> wallets = [
    "Cash",
    "Bank Account",
    "Credit Card",
    "Savings",
    "PayPal",
    "Investment",
    "Emergency Fund"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFD3C4A),
      //Color(0xFF0077FF)
      appBar: CommonAppBar(
        title: 'Expense',
        onBack: () {
          Get.back();
        },
        backGroundCol: Color(0xFFFD3C4A),
        iconColor: ColorManager.lightBackground,
        textColor: ColorManager.lightBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How much?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEDE9E9),
                    fontSize: 18,
                  ),
                ),
                const Text(
                  '\$0',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 64,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height / 35,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.height / 25),
                  topRight: Radius.circular(size.height / 25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 22, vertical: size.height / 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonDropdown(
                      value: selectedCategory,
                      items: categories,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value ?? "Food & Drinks";
                        });
                      },
                      hintText: "Category",
                      size: size,
                    ),
                    SizedBox(
                      height: size.height / 55,
                    ),
                    _buildTextField(size, descController, 'Description'),
                    SizedBox(
                      height: size.height / 55,
                    ),
                    CommonDropdown(
                      value: selectedWallet,
                      items: wallets,
                      onChanged: (value) {
                        setState(() {
                          selectedWallet = value ?? "Cash";
                        });
                      },
                      hintText: "Wallet",
                      size: size,
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 100),
                      child: DottedBorder(
                        color: Color(0xFFFAE7CF),
                        strokeWidth: 1.5,
                        dashPattern: [8, 4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 20,
                              vertical: size.height / 65),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: 0.4,
                                child: Icon(Icons.attach_file,
                                    color: Colors.black87),
                              ),
                              SizedBox(width: 8),
                              Text('Add attachment',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Repeat',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Repeat transaction',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                        Switch(
                          activeColor: ColorManager.lightBackground,
                          inactiveTrackColor: Color(0xFFD2D2D2),
                          focusColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: Color(0xFF749DD6),
                          value: checkBox,
                          onChanged: (bool value) {
                            setState(() {
                              checkBox = value;
                            });
                          },
                        )
                      ],
                    ),
                    Spacer(),
                    CustomButton(
                        text: 'Continue',
                        colorButton: Color(0xFFFD3C4A),
                        colorText: ColorManager.lightBackground,
                        onTap: () {})
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      Size size, TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 16),
      decoration: CommonStyles.inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }
}
