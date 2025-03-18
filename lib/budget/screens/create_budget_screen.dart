import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_appBar%20_widget.dart';
import 'package:spendo/widgets/common_drop_down_widget.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({super.key, required this.title});

  final String title;
  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  String? selectedCategory;

  List<String> categories = [
    "Shopping",
    "Food & Drinks",
    "Transport",
    "Entertainment",
    "Health & Fitness"
  ];
  bool checkBox = false;
  double sliderValue = 80;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF7F3DFF),
      appBar: CommonAppBar(
        title: widget.title,
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
            padding: EdgeInsets.symmetric(
                horizontal: size.width / 22, vertical: size.height / 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How much do yo want to spend?',
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                const Text(
                  '\$0',
                  style: TextStyle(
                      color: ColorManager.lightBackground,
                      fontWeight: FontWeight.w800,
                      fontSize: 45),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width / 22, vertical: size.height / 35),
            height:checkBox? size.height / 2.2:size.height / 2.6,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: ColorManager.lightBackground),
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
                  height: size.height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Receive Alert',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: size.height / 120,
                        ),
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
                        value: checkBox,
                        onChanged: (bool value) {
                          setState(() {
                            checkBox = !checkBox;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                if (checkBox) _showReceiveAlert(size,),
                const Spacer(),
                CustomButton(
                    text: 'Continue',
                    colorButton: const Color(0xFF7F3DFF),
                    colorText: ColorManager.lightBackground,
                    onTap: () {})
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _showReceiveAlert(Size size,) {
    return  Row(
      children: [
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              activeColor: const Color(0xFF7F3DFF),
              value: sliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: ' ${sliderValue.toInt()}% ',
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: size.width/99),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF7F3DFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${sliderValue.toInt()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
