import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:spendo/home/controllers/attachment_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/common_drop_down_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../commons/common_styles.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final TextEditingController descController = TextEditingController();
  final AttachmentController attachmentController = AttachmentController();
  bool checkBox = false;
  String? selectedCategory;
  String? selectedWallet;

  String? selectedFrequency;
  String? selectedDate;

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
  List<String> frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF00A86B),
      appBar: CommonAppBar(
        title: 'Income',
        onBack: () {
          Get.back();
        },
        backGroundCol: const Color(0xFF00A86B),
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
            child: const Column(
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
                Text(
                  '\$0',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 64,
                      height: 0),
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
                      height: size.height / 45,
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
                                  color: const Color(0xFFFAE7CF),
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
                      height: attachmentController.path.isEmpty
                          ? size.height / 30
                          : size.height / 45,
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
                              _showBottomSheetDate(value, context, size);
                            })
                      ],
                    ),
                    if (checkBox && selectedDate != null) ...[
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
                              Text(
                                selectedFrequency ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black87),
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
                                selectedDate ?? ''.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                          Container(
                            height: size.height / 28,
                            width: size.height / 15,
                            margin: EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF212221),
                            ),
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF96D8C0)),
                            ),
                          )
                        ],
                      ),
                    ],
                    const Spacer(),
                    CustomButton(
                        text: 'Continue',
                        colorButton: const Color(0xFF00A86B),
                        colorText: ColorManager.lightBackground,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
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
                                      height: size.height/6,
                                      width: size.height/6,
                                      fit: BoxFit.cover,
                                    ),
                                    const Text(
                                      "Transaction has been successfully added",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: size.height/80,)
                                  ],
                                ),
                              );
                            },
                          );
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

  void _showBottomSheetDate(bool value, BuildContext context, Size size) {
    if (value) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          String? tempSelectedDate = selectedDate;
          return StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                height: size.height / 3,
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
                      onChanged: (value) {
                        setState(() {
                          selectedFrequency = value ?? 'Frequency';
                        });
                      },
                      hintText: 'Frequency',
                    ),
                    SizedBox(height: size.height / 45),
                    DottedBorder(
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
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            setModalState(() {
                              selectedDate = tempSelectedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height / 67,
                              horizontal: size.width / 30),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFAF3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tempSelectedDate != null &&
                                        tempSelectedDate!.isNotEmpty
                                    ? selectedDate!
                                    : 'Select Date',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const Icon(Icons.calendar_today,
                                  color: Color(0xFF00A86B)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'Next',
                      colorButton: const Color(0xFF00A86B),
                      colorText: ColorManager.lightBackground,
                      onTap: () {
                        setState(() {
                          selectedDate = tempSelectedDate;
                          checkBox = true;
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

  Widget _buildTextField(
      Size size, TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 16),
      decoration: CommonStyles.inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }
}
