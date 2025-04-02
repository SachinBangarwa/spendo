import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';
import '../../widgets/common_app_bar _widget.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'Verification',
        onBack: () {
          FocusScope.of(context).unfocus();
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width / 22, vertical: size.height / 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height / 18),
            const Text(
              'Enter Your\nVerification Code',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height / 40),
            OTPInputFields(size: size),
            SizedBox(height: size.height / 40),
            const Text(
              '04:59',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height / 40),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(text: 'We sent a verification code to your email '),
                  TextSpan(
                    text: 'brajaoma*****@gmail.com.',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(text: ' Can you check your inbox?'),
                ],
              ),
            ),
            SizedBox(height: size.height / 40),
            const Text(
              'I didn’t receive the code? Send again',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.orange,
                decoration: TextDecoration.underline,
                decorationColor: Colors.orange,
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Verify',
              colorButton: ColorManager.primary,
              colorText: ColorManager.lightBackground,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class OTPInputFields extends StatefulWidget {
  final Size size;

  const OTPInputFields({super.key, required this.size});

  @override
  _OTPInputFieldsState createState() => _OTPInputFieldsState();
}

class _OTPInputFieldsState extends State<OTPInputFields> {
  late final List<TextEditingController> _controller;
  late final List<FocusNode> _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = List.generate(5, (index) => TextEditingController());
    _focusNode = List.generate(5, (index) => FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        return RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (event) {
            if (event is RawKeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace &&
                _controller[index].text.isEmpty &&
                index > 0) {
              FocusScope.of(context).requestFocus(_focusNode[index - 1]);
            }
          },
          child: Container(
            width: widget.size.width / 8,
            height: widget.size.height / 15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _controller[index],
              focusNode: _focusNode[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < 4) {
                  FocusScope.of(context).requestFocus(_focusNode[index + 1]);
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(_focusNode[index - 1]);
                }
              },
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    for (var controller in _controller) {
      controller.dispose();
    }
    for (var node in _focusNode) {
      node.dispose();
    }
    super.dispose();
  }
}
