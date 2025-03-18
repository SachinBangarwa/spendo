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

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height / 8),
            const Text(
              "Let's setup your account!",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: size.height / 50),
            const Text(
              "Account can be your bank, credit card or your wallet.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                height: 18 / 14,
              ),
            ),
            const Spacer(),
            CustomButton(
                text: "Let’s go",
                colorButton: ColorManager.primary,
                colorText: ColorManager.lightBackground,
                onTap: () {}),
            SizedBox(height: size.height / 30),
          ],
        ),
      ),
    );
  }
}


class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final TextEditingController _walletNameController = TextEditingController();
  String? selectedBank;
  String selectedAccountType = "Bank";

  final List<String> banks = [
    "Chase",
    "PayPal",
    "Citi",
    "BofA",
    "Jago",
    "Mandiri",
  ];

  final List<String> bankLogos = [
    "assets/icons/Bank.png",
    "assets/icons/Bank1.png",
    "assets/icons/Bank2.png",
    "assets/icons/Bank3.png",
    "assets/icons/Bank4.png",
    "assets/icons/Bank5.png",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: size.height / 10,
        backgroundColor: ColorManager.primary,
        leading: GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 300));
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.keyboard_backspace_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),
        title: const Text(
          'Add New Wallet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Balance",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                const Text(
                  "\$00.0",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: size.height / 1.8,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width / 12),
                topRight: Radius.circular(size.width / 12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / 22, vertical: size.height / 55),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 40,
                  ),
                  _buildTextField(size, _walletNameController, 'Wallet Name'),
                  SizedBox(height: size.height / 40),
                  DropdownButtonFormField<String>(
                    value: selectedBank,
                    decoration: _inputDecoration('Select Bank', size),
                    items: banks
                        .map((bank) =>
                            DropdownMenuItem(value: bank, child: Text(bank)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBank = value;
                      });
                    },
                  ),
                  SizedBox(height: size.height / 20),
                  _buildBankIcons(size),
                  Spacer(),
                  CustomButton(
                    text: 'Continue',
                    colorButton: ColorManager.primary,
                    colorText: ColorManager.lightBackground,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      Size size, TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: _inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }

  InputDecoration _inputDecoration(String hintText, Size size) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: size.width / 20, vertical: size.height / 46),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFFDEEDB), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.primary, width: 2),
      ),
    );
  }

  Widget _buildBankIcons(Size size) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: size.width * 0.02,
        mainAxisSpacing: size.height * 0.02,
        childAspectRatio: (size.width / 4.5) / (size.height / 20),
      ),
      itemCount: banks.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedBank = banks[index];
            });
          },
          child: Container(
            width: size.width / 4.5,
            height: size.height / 20,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: selectedBank == banks[index]
                  ? Colors.blue.withOpacity(0.2)
                  : const Color(0xFFF1F1FA), // Default Background Color
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: index == 7
                  ? Text(
                      "See Other",
                      style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 10),
                    )
                  : Image.asset(bankLogos[index], height: 24),
            ),
          ),
        );
      },
    );
  }
}

class SetupSuccessScreen extends StatelessWidget {
  const SetupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/success_account.json',
                height: 200, width: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            const Text(
              "You are set!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

