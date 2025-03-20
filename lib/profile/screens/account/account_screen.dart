import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/profile/screens/account/add_account_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../../widgets/common_appBar _widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
          Text(
            'Account Balance',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            '\$9400',
            style: TextStyle(
              fontSize: size.width * 0.1,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Divider(height: size.height/20,color: Colors.black12.withOpacity(0.1),),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              children: [
                buildAccountTile('Wallet', '\$400', 'assets/icons/wallet.png',size),
                Divider(height: size.height/40,color: Colors.black12.withOpacity(0.1),),

                buildAccountTile('Chase', '\$1000', 'assets/icons/Bank.png',size),
                Divider(height: size.height/40,color: Colors.black12.withOpacity(0.1),),

                buildAccountTile('Citi', '\$6000', 'assets/icons/Bank.png',size),
                Divider(height: size.height/40,color: Colors.black12.withOpacity(0.1),),

                buildAccountTile('Paypal', '\$2000', 'assets/icons/Bank1.png',size),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.03,horizontal: size.width/22),
            child: CustomButton(
              text: '+ Add new wallet',
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () {
                Get.to(()=>AddAccountScreen());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAccountTile(String title, String amount, String iconPath, Size size) {
    return ListTile(
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
      title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,height: 0)),
      trailing: Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }
}
