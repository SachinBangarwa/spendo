import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/profile/controllers/total_balance_controller.dart';
import 'package:spendo/profile/screens/account/add_account_screen.dart';
import 'package:spendo/profile/screens/account/detail_account_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../../widgets/common_appBar _widget.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final TotalBalanceController totalBalanceController =
      Get.put(TotalBalanceController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'Account',
        backGroundCol: Colors.white,
        onBack: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          const Text(
            'Account Balance',
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.height * 0.01),
          Obx(() => Expanded(
            flex: 1,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width/22),
              child: Text(
                "₹${totalBalanceController.totalBalance.value.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: size.width * 0.1,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          )),
          Divider(
            height: size.height / 20,
            color: Colors.black12.withOpacity(0.1),
          ),
          Expanded(
            flex: 5,
            child: Obx(() {
              if (totalBalanceController.accountsList.isEmpty) {
                return Center(
                  child: Text(
                    "No accounts available",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                );
              }
              return ListView.builder(
                itemCount: totalBalanceController.accountsList.length,
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                itemBuilder: (context, index) {
                  Map<String,dynamic> account = totalBalanceController.accountsList[index];
                  return Column(
                    children: [
                      buildAccountTile(
                      account,
                        account['type'] == 'Bank' ? 'assets/icons/Bank.png' : 'assets/icons/wallet.png',
                        size,
                      ),
                      Divider(
                        height: size.height / 40,
                        color: Colors.black12.withOpacity(0.1),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03, horizontal: size.width / 22),
            child: CustomButton(
              text: '+ Add new wallet',
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () {
                Get.to(() => AddAccountScreen());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAccountTile(
      Map<String,dynamic> account, String iconPath, Size size) {
    return ListTile(
      onTap: (){
        Get.to(()=>DetailAccountScreen(account: account,));
      },
      leading: Container(
        width: size.width / 7,
        height: size.width / 7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFF1F1FA),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.width / 30),
          child: Image.asset(
            iconPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Text( account['name'] ?? 'Unknown',
          style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 0)),
      trailing: Text('₹${account['balance'] ?? 0.0}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }
}
