import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/home/controllers/attachment_controller.dart';
import 'package:spendo/home/controllers/add_transaction_controller.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_app_bar%20_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';
import '../../commons/common_styles.dart';

class EditeTransferTransactionScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const EditeTransferTransactionScreen({
    super.key,
    required this.data,
  });

  @override
  State<EditeTransferTransactionScreen> createState() =>
      _EditeTransferTransactionScreen();
}

class _EditeTransferTransactionScreen
    extends State<EditeTransferTransactionScreen> {
  late TextEditingController descController;
  late TextEditingController amountController;
  late TextEditingController fromController;
  late TextEditingController toController;

  final AttachmentController attachmentController =
      Get.put(AttachmentController());
  final AddTransactionController addTransactionController =
      Get.put(AddTransactionController());
  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  void initState() {
    super.initState();

    descController =
        TextEditingController(text: widget.data['description'] ?? '');
    amountController =
        TextEditingController(text: widget.data['amount']?.toString() ?? '0.0');
    fromController =
        TextEditingController(text: widget.data['fromAccountType'] ?? '');
    toController =
        TextEditingController(text: widget.data['toAccountType'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF0077FF),
      appBar: CommonAppBar(
        title: 'Transfer',
        onBack: () {
          Get.back();
        },
        backGroundCol: Color(0xFF0077FF),
        iconColor: ColorManager.lightBackground,
        textColor: ColorManager.lightBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height / 9.5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How much?',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFEDE9E9),
                      fontSize: 18,
                      height: 0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '₹ ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          height: 0),
                    ),
                    buildBalanceTextField(size, amountController),
                  ],
                ),
              ],
            ),
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
                padding: EdgeInsets.only(
                    left: size.width / 22,
                    right: size.width / 22,
                    top: size.height / 35,
                    bottom: size.height / 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height / 90,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: _buildTextField(
                              size, fromController, 'From', Color(0xFF0077FF)),
                        ),
                        Image.asset(
                          'assets/icons/transaction.png',
                          height: size.height / 20,
                        ),
                        Flexible(
                          child: _buildTextField(
                              size, toController, 'To', Color(0xFF0077FF)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 25,
                    ),
                    _buildTextField(
                        size, descController, 'Description', Color(0xFF0077FF)),
                    SizedBox(
                      height: size.height / 25,
                    ),
                    Obx(() {
                      return attachmentController.path.value != ''
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: size.width / 3.5,
                                  height: size.height / 7.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    color: Colors.grey[200],
                                  ),
                                  child: attachmentController.isImage()
                                      ? Image.file(
                                          File(attachmentController.path.value),
                                          fit: BoxFit.cover)
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                  Icons.insert_drive_file,
                                                  size: 40,
                                                  color: Colors.black54),
                                              const SizedBox(height: 4),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  attachmentController
                                                      .getFileName(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                                Positioned(
                                  top: -8,
                                  right: -8,
                                  child: GestureDetector(
                                    onTap: () {
                                      attachmentController.path.value = '';
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Icon(Icons.cancel,
                                          color: Colors.black, size: 28),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / 100),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (index) {
                                        return Container(
                                          height: size.height / 5,
                                          width: size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width / 22),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  topLeft:
                                                      Radius.circular(30))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(6),
                                                width: size.width / 8,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFA5BBB3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                              SizedBox(
                                                  height: size.height / 25),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _buildAttachment(
                                                    size,
                                                    const Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color: Colors.white,
                                                        size: 30),
                                                    'Camera',
                                                    () async {
                                                      await attachmentController
                                                          .getCamera();
                                                      Get.back();
                                                    },
                                                  ),
                                                  _buildAttachment(
                                                    size,
                                                    const Icon(
                                                        Icons.image_outlined,
                                                        color: Colors.white,
                                                        size: 30),
                                                    'Image',
                                                    () async {
                                                      await attachmentController
                                                          .getImage();
                                                      Get.back();
                                                    },
                                                  ),
                                                  _buildAttachment(
                                                    size,
                                                    const Icon(
                                                        Icons
                                                            .insert_drive_file_outlined,
                                                        color: Colors.white,
                                                        size: 30),
                                                    'Document',
                                                    () async {
                                                      await attachmentController
                                                          .getDocument();
                                                      Get.back();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: DottedBorder(
                                  color:
                                      const Color(0xFF0077FF).withOpacity(0.3),
                                  strokeWidth: 1.5,
                                  dashPattern: const [8, 4],
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width / 20,
                                        vertical: size.height / 65),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform.rotate(
                                          angle: 0.4,
                                          child: const Icon(Icons.attach_file,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text('Add attachment',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }),
                    const Spacer(),
                    CustomButton(
                        text: 'Continue',
                        colorButton: Color(0xFF0077FF),
                        colorText: ColorManager.lightBackground,
                        onTap: () async {
                          double? amount =
                              double.tryParse(amountController.text);
                          if (amount == null || amount <= 0.0) {
                            showCustomSnackBar(
                                'Error', 'Please enter a valid amount',
                                isSuccess: false);
                          } else if (descController.text.isEmpty) {
                            showCustomSnackBar(
                                'Error', 'Please enter a description',
                                isSuccess: false);
                          } else {
                            String? fromId = await addTransactionController
                                .getAccountIdByName(fromController.text.trim());
                            String? toId = await addTransactionController
                                .getAccountIdByName(toController.text.trim());
                            await transactionController
                                .upDateTransaction(
                              transactionId: widget.data['transactionId'],
                              amount: amount,
                              category: '',
                              description: descController.text,
                              fromAccountId: fromId ?? '',
                              fromAccountType: fromController.text,
                              type: 'Transfer',
                              imageUrl: attachmentController.path.value,
                              toAccountId: toId ?? '',
                              toAccountType: toController.text,
                            )
                                .then((onValue) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return _buildDialogSuccessAdded(size);
                                },
                              );

                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pop(context);
                                Get.offAll(() => DashBoardScreen());
                              });
                            });
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
            "Transaction has been successfully added",
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

  Widget _buildAttachment(
      Size size, Icon icon, String title, VoidCallback onTab) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: size.width / 3.9,
        height: size.height / 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF66CDAA)),
        child: Padding(
          padding: EdgeInsets.all(size.width / 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(Size size, TextEditingController controller,
      String hintText, Color themColor) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 16),
      decoration:
          CommonStyles.inputDecoration(hintText, size, borderColor: themColor),
      cursorColor: ColorManager.primary,
    );
  }

  Widget buildBalanceTextField(
    Size size,
    TextEditingController controller,
  ) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
      ),
    );
  }
}
