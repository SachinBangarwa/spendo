import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

class PinScreen extends StatefulWidget {
  final String title;
  final Function(List<String>) onSubmit;

  const PinScreen({super.key, required this.title, required this.onSubmit});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
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
          Spacer(),
          _buildKeypad(),
          SizedBox(height: size.height / 30),
        ],
      ),
    );
  }
}

/// **Pin Setup Screen**
class PinSetupScreen extends StatelessWidget {
  const PinSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PinScreen(
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

/// **Confirm Pin Screen**
class ConfirmPinScreen extends StatelessWidget {
  final List<String> setupPin;

  const ConfirmPinScreen({super.key, required this.setupPin});

  @override
  Widget build(BuildContext context) {
    return PinScreen(
      title: "Ok. Re-type your PIN again.",
      onSubmit: (confirmPin) {
        if (setupPin.join() == confirmPin.join()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("PIN setup successfully!")),
          );
          // TODO: Save PIN and navigate
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("PINs do not match, try again!")),
          );
          Navigator.pop(context);
        }
      },
    );
  }
}





