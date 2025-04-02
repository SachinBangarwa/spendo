import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/home/controllers/attachment_controller.dart';
import 'package:spendo/home/controllers/add_transaction_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_app_bar%20_widget.dart';
import 'package:spendo/widgets/common_drop_down_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';

import '../../commons/common_styles.dart';

class CommonTransactionScreen extends StatefulWidget {
  final String type;

  const CommonTransactionScreen({super.key, required this.type});

  @override
  State<CommonTransactionScreen> createState() => _CommonTransactionScreen();
}

class _CommonTransactionScreen extends State<CommonTransactionScreen> {
  final TextEditingController descController = TextEditingController();
  final TextEditingController amountController =
      TextEditingController(text: '0.0');
  final AttachmentController attachmentController =
      Get.put(AttachmentController());

  final AddTransactionController addTransactionController =
      Get.put(AddTransactionController());

  bool checkBox = false;
  String? selectedCategory;
  String? selectedWallet;
  String? selectedStartDate;
  String? selectedEndDate;
  String? selectedFrequency;

  final List<String> incomeCategories = [
    "Salary",
    "Freelance",
    "Investments",
    "Gifts",
    "Business"
  ];

  final List<String> expenseCategories = [
    "Shopping",
    "Food & Drinks",
    "Transport",
    "Entertainment",
    "Health & Fitness"
  ];
  List<String> frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  List<String> wallets = [
    "Paytm Wallet",
    "Google Pay Wallet",
    "PhonePe Wallet",
    "Amazon Pay Wallet",
    "State Bank of India (SBI)",
    "HDFC Bank",
    "Punjab National Bank (PNB)",
    "ICICI Bank"
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories =
        widget.type == "Income" ? incomeCategories : expenseCategories;
    Color themeColor = widget.type == "Income"
        ? const Color(0xFF00A86B)
        : const Color(0xFFFD3C4A);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeColor,
      appBar: CommonAppBar(
        title: widget.type,
        onBack: () {
          Get.back();
        },
        backGroundCol: themeColor,
        iconColor: ColorManager.lightBackground,
        textColor: ColorManager.lightBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !checkBox
              ? SizedBox(
                  height: size.height / 20,
                )
              : SizedBox(
                  height: size.height / 55,
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
                      height: 0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
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
          if (!checkBox)
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
                padding: EdgeInsets.only(
                    left: size.width / 22,
                    right: size.width / 22,
                    top: size.height / 35,
                    bottom: attachmentController.path.isNotEmpty
                        ? size.height / 55
                        : size.height / 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonDropdown(
                      value: selectedCategory,
                      items: categories,
                      borderColor: themeColor,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value ?? "Salary";
                        });
                      },
                      hintText: "Category",
                      size: size,
                    ),
                    SizedBox(
                      height: size.height / 55,
                    ),
                    _buildTextField(
                        size, descController, 'Description', themeColor),
                    SizedBox(
                      height: size.height / 55,
                    ),
                    CommonDropdown(
                      value: selectedWallet,
                      items: wallets,
                      borderColor: themeColor,
                      onChanged: (value) {
                        setState(() {
                          selectedWallet = value ?? "Paytm Wallet";
                        });
                      },
                      hintText: " Select Wallet",
                      size: size,
                    ),
                    SizedBox(
                      height: size.height / 45,
                    ),
                    Obx(() {
                      return attachmentController.path.value != ''
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: size.width / 3.5,
                                  height: size.height / 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    color: Colors.grey[200],
                                  ),
                                  child: attachmentController.isImage()
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(attachmentController
                                                .path.value),
                                            fit: BoxFit.cover,
                                            height: size.height / 8,
                                          ),
                                        )
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
                                  color: themeColor.withOpacity(0.3),
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
                    SizedBox(
                      height: size.width / 55,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
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
                            activeColor: const Color(0xFF96D8C0),
                            inactiveTrackColor: const Color(0xFFBDBDBD),
                            focusColor: Colors.white,
                            inactiveThumbColor: Colors.white,
                            activeTrackColor: const Color(0xFF212221),
                            value: checkBox,
                            onChanged: (bool value) {
                              if (checkBox) {
                                setState(() {
                                  checkBox = !checkBox;
                                });
                              }
                              _showBottomSheetDate(
                                  value, context, size, themeColor);
                            })
                      ],
                    ),
                    if (checkBox &&
                        selectedStartDate != null &&
                        selectedEndDate != null &&
                        selectedFrequency != null &&
                        selectedFrequency!.isNotEmpty) ...[
                      SizedBox(
                        height: size.height / 55,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Frequency',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text(
                                    selectedFrequency ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    width: size.width / 100,
                                  ),
                                  Text(
                                    selectedStartDate ?? ''.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Colors.black87),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'End After',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              Text(
                                selectedEndDate ?? ''.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheetDate(
                                  true, context, size, themeColor);
                            },
                            child: Container(
                              height: size.height / 28,
                              width: size.height / 15,
                              margin: const EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFF212221),
                              ),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF96D8C0)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                    const Spacer(),
                    CustomButton(
                        text: 'Continue',
                        colorButton: themeColor,
                        colorText: ColorManager.lightBackground,
                        onTap: () async {
                          double? amount =
                              double.tryParse(amountController.text);
                          if (amount == null ||
                              amountController.text.isEmpty ||
                              amount <= 0.0) {
                            showCustomSnackBar(
                                'Error', 'Please enter a valid amount',
                                isSuccess: false);
                          } else if (selectedCategory == null) {
                            showCustomSnackBar(
                                'Error', 'Please select a category',
                                isSuccess: false);
                          } else if (selectedWallet == null) {
                            showCustomSnackBar('Error',
                                'Please select a wallet or bank account',
                                isSuccess: false);
                          } else {
                            await addTransactionController
                                .addTransaction(
                              amount: amount,
                              category: selectedCategory!,
                              description: descController.text,
                              fromAccountId: 'fromAccountId',
                              fromAccountType: selectedWallet!,
                              type: widget.type,
                              isRepeat: checkBox,
                              frequency: selectedFrequency,
                              startDate: selectedStartDate,
                              endDate: selectedEndDate,
                              imageUrl: attachmentController.path.value,
                              toAccountId: '',
                              toAccountType: '',
                            )
                                .then((onValue) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return _buildDialogSuccessAdded(size);
                                },
                              );

                              Future.delayed(const Duration(seconds: 1), () {
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

  void _showBottomSheetDate(
      bool value, BuildContext context, Size size, Color themeColor) {
    if (value) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          String? tempStartDate = selectedStartDate;
          String? tempEndDate = selectedEndDate;
          return StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                height: size.height / 2.5,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width / 22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        width: size.width / 8,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA5BBB3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height / 45),
                    CommonDropdown(
                      size: size,
                      value: selectedFrequency,
                      items: frequencies,
                      borderColor: themeColor,
                      onChanged: (value) {
                        setState(() {
                          selectedFrequency = value ?? 'Daily';
                        });
                      },
                      hintText: 'Frequency',
                    ),
                    SizedBox(height: size.height / 45),
                    _buildDatePicker(
                      context,
                      size,
                      "Start Date",
                      tempStartDate,
                      (selected) {
                        setModalState(() {
                          selectedStartDate = tempStartDate =
                              DateFormat('yyyy-MM-dd').format(selected);
                        });
                      },
                    ),
                    SizedBox(height: size.height / 45),
                    _buildDatePicker(
                      context,
                      size,
                      "End Date",
                      tempEndDate,
                      (selected) {
                        setModalState(() {
                          selectedEndDate = tempEndDate =
                              DateFormat('yyyy-MM-dd').format(selected);
                        });
                      },
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'Next',
                      colorButton: themeColor,
                      colorText: ColorManager.lightBackground,
                      onTap: () {
                        setState(() {
                          bool isCondition = selectedStartDate == null ||
                              selectedEndDate == null ||
                              selectedFrequency == null ||
                              selectedFrequency!.isEmpty;
                          checkBox = !isCondition;
                        });
                        Get.back();
                      },
                    ),
                    SizedBox(height: size.height / 90),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }

  Widget _buildDatePicker(
    BuildContext context,
    Size size,
    String label,
    String? selectedDate,
    Function(DateTime) onDateSelected,
  ) {
    return DottedBorder(
      color: const Color(0xFFFDEEDB),
      strokeWidth: 1.5,
      dashPattern: const [6, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(20),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
          );

          if (pickedDate != null) {
            onDateSelected(pickedDate);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: size.height / 67, horizontal: size.width / 30),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFAF3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate != null && selectedDate.isNotEmpty
                    ? selectedDate
                    : label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Icon(Icons.calendar_today, color: Color(0xFF00A86B)),
            ],
          ),
        ),
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
