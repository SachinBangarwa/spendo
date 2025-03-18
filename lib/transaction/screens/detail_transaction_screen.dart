import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class DetailTransactionScreen extends StatelessWidget {
  const DetailTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorManager.lightBackground,
        appBar: CommonAppBar(
          title: 'Detail Transaction',
          backGroundCol: Color(0xFFFD3C4A),
          iconColor: ColorManager.lightBackground,
          textColor: ColorManager.lightBackground,
          onBack: () {
            Get.back();
          },
          trailing: Padding(
            padding: EdgeInsets.only(right: size.width / 22),
            child: Icon(
              Icons.restore_from_trash,
              size: 28,
              color: ColorManager.lightBackground,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height / 4,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFD3C4A),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height / 55,
                    ),
                    Text(
                      '\$120',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          height: 0),
                    ),
                    SizedBox(
                      height: size.height / 55,
                    ),
                    Text(
                      'Buy some grocery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Saturday 4 June 2021    16:20',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width / 500,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -size.height / 22,
                      left: size.width / 22,
                      right: size.width / 22,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Color(0xFFFDFDFD),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 22,
                              vertical: size.height / 66),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _transactionDetailItem('Type', 'Expense', size),
                              _transactionDetailItem(
                                  'Category', 'Shopping', size),
                              _transactionDetailItem('Wallet', 'Wallet', size),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size.width / 22,
                  right: size.width / 22,
                  top: size.height / 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 120,
                    ),
                    const Text(
                      'Amet minim mollit non  est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 120,
                    ),
                    const Text(
                      'Attachment',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF91919F),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 55,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/Rectangle207.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width / 22, vertical: size.height / 55),
          child: CustomButton(
              text: 'Edit',
              colorButton: Color(0xFFFD3C4A),
              colorText: ColorManager.lightBackground,
              onTap: () {}),
        ));
  }
}

Widget _transactionDetailItem(String label, String value, Size size) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      SizedBox(
        height: size.height / 200,
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
