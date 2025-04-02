import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_drop_down_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';
import '../../widgets/common_app_bar _widget.dart';
import '../controllers/budget_controller.dart';

class EditBudgetScreen extends StatefulWidget {
  final String? budgetId;
  final String? category;
  final double? amount;

  const EditBudgetScreen({
    super.key,
    this.budgetId,
    this.category,
    this.amount,
  });

  @override
  State<EditBudgetScreen> createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  final BudgetController budgetController = Get.put(BudgetController());
  late TextEditingController amountController;
  late String selectedCategory;

  List<String> categories = [
    "Shopping",
    "Food & Drinks",
    "Transport",
    "Entertainment",
    "Health & Fitness"
  ];

  @override
  void initState() {
    super.initState();

    amountController = TextEditingController(
        text: widget.amount != null ? widget.amount!.toStringAsFixed(1) : '');

    selectedCategory = widget.category ?? 'Shopping';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF7F3DFF),
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: 'Edit Budget',
        textColor: ColorManager.lightBackground,
        iconColor: ColorManager.lightBackground,
        backGroundCol: const Color(0xFF7F3DFF),
        onBack: () => Get.back(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How much do you want to spend?',
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                Row(
                  children: [
                    const Text(
                      '₹',
                      style: TextStyle(
                          color: ColorManager.lightBackground,
                          fontWeight: FontWeight.w800,
                          fontSize: 36),
                    ),
                    buildBalanceTextField(size, amountController),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width / 22, vertical: size.height / 40),
            height: size.height / 2.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              color: ColorManager.lightBackground,
            ),
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
                SizedBox(height: size.height / 30),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Receive Alert',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            SizedBox(height: size.height / 120),
                            Text(
                              'Receive alert when it reaches\nsome point.',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                  height: 0),
                            ),
                          ],
                        ),
                        Switch(
                          activeColor: const Color(0xFF96D8C0),
                          inactiveTrackColor: const Color(0xFFBDBDBD),
                          focusColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: const Color(0xFF212221),
                          value: budgetController.checkBox.value,
                          onChanged: budgetController.toggleAlert,
                        ),
                      ],
                    )),
                SizedBox(height: size.height / 40),
                Obx(() => budgetController.checkBox.value
                    ? _showReceiveAlert(size)
                    : const SizedBox()),
                const Spacer(),
                CustomButton(
                  text: 'Update',
                  colorButton: const Color(0xFF7F3DFF),
                  colorText: ColorManager.lightBackground,
                  onTap: () async {
                    try {
                      String amountText = amountController.text.trim();
                      double? amount = double.tryParse(amountText);

                      if (amount == null || amount <= 0.0) {
                        showCustomSnackBar(
                            'Error', 'Please enter a valid amount',
                            isSuccess: false);
                        return;
                      } else {
                        await budgetController.updateBudget(
                            widget.budgetId!, selectedCategory, amountText);
                        Navigator.pop(context);
                      }
                      if (mounted) {
                        Get.back();
                      }
                    } catch (e) {
                      showCustomSnackBar('Error', 'Something went wrong!',
                          isSuccess: false);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showReceiveAlert(Size size) {
    final BudgetController budgetController = Get.find();
    return Obx(() => Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(Get.context!).copyWith(
                    trackHeight: 10,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 12)),
                child: Slider(
                  activeColor: const Color(0xFF7F3DFF),
                  value: budgetController.sliderValue.value,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: '${budgetController.sliderValue.value.toInt()}%',
                  onChanged: budgetController.updateSlider,
                ),
              ),
            ),
            SizedBox(width: size.width / 99),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: const Color(0xFF7F3DFF),
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                '${budgetController.sliderValue.value.toInt()}%',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  Widget buildBalanceTextField(Size size, TextEditingController controller) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(border: InputBorder.none),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
      ),
    );
  }
}
