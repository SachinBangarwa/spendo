import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/screens/pin_code_screen.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/profile/controllers/add_account_controller.dart';
import 'package:spendo/profile/screens/account/add_bank_screen.dart';
import 'package:spendo/profile/screens/account/add_wallet_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {

  final AddAccountController _addAccountController=Get.put(AddAccountController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController(text: '0.0');
  bool isBalanceEditable = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: true,
      appBar: CommonAppBar(
        title: 'Add new account',
        backGroundCol: ColorManager.primary,
        iconColor: Colors.white,
        textColor: Colors.white,
        onBack: () async {
          FocusScope.of(context).unfocus();
          await Future.delayed(const Duration(milliseconds: 300));
          Get.back();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Balance",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 0,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '₹',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          height: 0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: size.width / 100,
                    ),
                    CommonStyles.buildBalanceTextField(
                        size, _balanceController,RxDouble(0.0)),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: size.height / 2.6,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width / 12),
                topRight: Radius.circular(size.width / 12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 22, vertical: size.height / 55),
              child: Column(
                children: [
                  SizedBox(height: size.height / 35),
                  _buildTextField(size, _nameController, 'Name'),
                  SizedBox(height: size.height / 35),
                  DropdownButtonFormField<String>(
                    value: _addAccountController.selectedAccountType.value,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    decoration:
                        CommonStyles.inputDecoration('Account Type', size),
                    items: ["Bank", "Wallet"]
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) {
                      _addAccountController.changeDropValue(value??'Bank');
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Continue',
                    colorButton: ColorManager.primary,
                    colorText: ColorManager.lightBackground,
                    onTap: () async {

                      double balance =
                          double.tryParse(_balanceController.text) ?? 0.0;

                      if (_addAccountController.selectedAccountType.value == 'Wallet') {
                        Get.to(() => AddWalletScreen(
                              balance: balance.toString(),
                              name: _nameController.text,
                            ));
                      } else {
                        Get.to(() => AddBankScreen(
                          balance: balance.toString(),
                          name: _nameController.text,
                        ));
                      }
                    },
                  )
                ],
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
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: CommonStyles.inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }
}
