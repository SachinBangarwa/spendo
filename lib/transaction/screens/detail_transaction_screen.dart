import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/transaction/screens/edite_transaction_screen.dart';
import 'package:spendo/transaction/screens/edite_transfer_transaction_screen.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class DetailTransactionScreen extends StatefulWidget {
  const DetailTransactionScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<DetailTransactionScreen> createState() =>
      _DetailTransactionScreenState();
}

class _DetailTransactionScreenState extends State<DetailTransactionScreen> {
  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTransfer = widget.data['type'] == 'Transfer';
    Color color = widget.data['type'] == 'Expense'
        ? const Color(0xFFFD3C4A)
        : widget.data['type'] == 'Transfer'
            ? const Color(0xFF0077FF)
            : const Color(0xFF00A86B);
    return Scaffold(
        backgroundColor: ColorManager.lightBackground,
        appBar: CommonAppBar(
          title: 'Detail Transaction',
          backGroundCol: color,
          iconColor: ColorManager.lightBackground,
          textColor: ColorManager.lightBackground,
          onBack: () {
            Get.back();
          },
          onTrailingTap: () async {
            _removeTransactionButton(
                context, size, transactionController, widget.data);
          },
          trailing: Padding(
            padding: EdgeInsets.only(right: size.width / 22),
            child: const Icon(
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
                decoration: BoxDecoration(
                  color: widget.data['type'] == 'Expense'
                      ? const Color(0xFFFD3C4A)
                      : widget.data['type'] == 'Transfer'
                          ? const Color(0xFF0077FF)
                          : const Color(0xFF00A86B),
                  borderRadius: const BorderRadius.only(
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
                      "₹${widget.data['amount'].toString()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          height: 0),
                    ),
                    SizedBox(
                      height: size.height / 55,
                    ),
                    const Text(
                      'Buy some grocery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.data['date'] != null
                          ? DateFormat("yyyy-MM-dd HH:mm:ss").format(
                              DateTime.parse(widget.data['date']).toLocal())
                          : "No Date Available",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
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
                        color: const Color(0xFFFDFDFD),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 22,
                              vertical: size.height / 66),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _transactionDetailItem(
                                  'Type', widget.data['type'], size),
                              _transactionDetailItem(
                                  isTransfer ? 'From' : 'Category',
                                  isTransfer
                                      ? widget.data['fromAccountType']
                                      : widget.data['category'],
                                  size),
                              _transactionDetailItem(
                                  isTransfer ? 'TO' : 'Wallet',
                                  isTransfer
                                      ? widget.data['toAccountType']
                                      : widget.data['fromAccountType'],
                                  size),
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
                    Text(
                      widget.data['description'] ?? 'No description added',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
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
              colorButton: color,
              colorText: ColorManager.lightBackground,
              onTap: () {
                if (widget.data['type'] == 'Expense' ||
                    widget.data['type'] == 'Income') {
                  Get.to(() => EditeTransactionScreen(
                        data: widget.data,
                      ));
                } else {
                  Get.to(() => EditeTransferTransactionScreen(
                        data: widget.data,
                      ));
                }
              }),
        ));
  }

  Widget _transactionDetailItem(String label, String value, Size size) {
    return Expanded(
      // Auto-resize karne ke liye
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis, // Agar text bada ho to ...
            maxLines: 1, // Ek hi line me dikhana hai
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
            overflow: TextOverflow.ellipsis,
            // Overflow hone par truncate karega
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  void _removeTransactionButton(BuildContext context, Size size,
      TransactionController transactionController, dynamic data) {
    showModalBottomSheet(
        context: context,
        builder: (index) {
          return Container(
            height: size.height / 3.8,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(6),
                  width: size.width / 8,
                  height: 5,
                  decoration: BoxDecoration(
                      color: const Color(0xFFA5BBB3),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(height: size.height / 55),
                Text(
                  'Remove this budget?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: size.height / 55),
                Text(
                  'Are you sure do you wanna remove this\n                           budget?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFEFEDED)),
                          child: Text(
                            'No',
                            style: TextStyle(
                                color: Color(0xFF7F3DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 25,
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () async {
                          await transactionController
                              .deleteTransaction(data['transactionId'])
                              .then((onValue) async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return _buildDialogSuccessAdded(
                                  size,
                                );
                              },
                            );
                          await  Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pop(context);
                              Get.back();
                            });
                          });
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFEFEDED)),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Color(0xFF7F3DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height / 35),
              ],
            ),
          );
        });
  }

  Dialog _buildDialogSuccessAdded(Size size) {
    return Dialog(
      backgroundColor: ColorManager.lightBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/icons/success_account.json',
            height: size.height / 6,
            width: size.height / 6,
            fit: BoxFit.cover,

          ),
          const Text(
            "Transaction has been successfully Remove",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: size.height / 80,
          )
        ],
      ),
    );
  }
}
