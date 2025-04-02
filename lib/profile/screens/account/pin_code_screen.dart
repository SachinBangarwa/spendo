import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/dashboard/dash_board_screen.dart';
import 'package:spendo/profile/controllers/user_detail_controller.dart';
import 'package:spendo/profile/screens/setting/security_screen.dart';
import 'package:spendo/theme/color_manager.dart';

class PinCodeScreen extends StatefulWidget {
  final String title;
  final Function(List<String>) onSubmit;

  const PinCodeScreen({super.key, required this.title, required this.onSubmit});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  List<String> pin = [];

  void _onKeyPressed(String value) {
    if (pin.length < 4) {
      setState(() {
        pin.add(value);
      });
    }
  }

  void _onDeletePressed() {
    if (pin.isNotEmpty) {
      setState(() {
        pin.removeLast();
      });
    }
  }

  void _onSubmit() {
    if (pin.length == 4) {
      widget.onSubmit(pin);
    }
  }

  Widget _buildPinIndicator(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        bool isFilled = index < pin.length;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: size.width / 40),
          width: size.width / 18,
          height: size.height / 18,
          decoration: BoxDecoration(
            color: isFilled ? Colors.white : Colors.white.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildKeypadButton(String number) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => _onKeyPressed(number),
      child: Container(
        width: size.width / 10,
        height: size.height / 10,
        alignment: Alignment.center,
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['1', '2', '3'].map(_buildKeypadButton).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['4', '5', '6'].map(_buildKeypadButton).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['7', '8', '9'].map(_buildKeypadButton).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: _onDeletePressed,
              child: const Icon(Icons.backspace, color: Colors.white, size: 32),
            ),
            _buildKeypadButton('0'),
            GestureDetector(
              onTap: _onSubmit,
              child: const Icon(Icons.arrow_forward,
                  color: Colors.white, size: 32),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height / 4),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: size.height / 14),
          _buildPinIndicator(size),
          const Spacer(),
          _buildKeypad(),
          SizedBox(height: size.height / 30),
        ],
      ),
    );
  }
}

class PinSetupScreen extends StatelessWidget {
  const PinSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeScreen(
      title: "Let's setup your PIN",
      onSubmit: (pin) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmPinScreen(setupPin: pin),
          ),
        );
      },
    );
  }
}

class ConfirmPinScreen extends StatelessWidget {
  final List<String> setupPin;

  ConfirmPinScreen({super.key, required this.setupPin});

  final UserDetailController userDetailController =
      Get.put(UserDetailController());

  @override
  Widget build(BuildContext context) {
    return PinCodeScreen(
      title: "Ok. Re-type your PIN again.",
      onSubmit: (confirmPin) async {
        if (setupPin.join() == confirmPin.join()) {
          bool conform =
              await userDetailController.lockAccount(confirmPin.join());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("PIN setup successfully!"),
              duration: Duration(seconds: 1),
            ),
          );
          if (conform) {
            Get.off(() => SecurityScreen())!.then((_) {
              Get.offAll(() => DashBoardScreen(selectedIndex: 3));
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("PINs do not match, try again!"),
              duration: Duration(seconds: 1),
            ),
          );
          Navigator.pop(context);
        }
      },
    );
  }
}
