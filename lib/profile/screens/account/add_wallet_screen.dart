import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/profile/screens/account/add_account_success_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';
import '../../../widgets/common_app_bar _widget.dart';
import 'package:spendo/profile/controllers/add_wallet_controller.dart';

class AddWalletScreen extends StatefulWidget {
  final String? name;
  final dynamic balance;

  const AddWalletScreen({super.key, required this.name, required this.balance});

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final AddWalletController _walletController = Get.put(AddWalletController());

  final TextEditingController _balanceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    double initialBalance = double.tryParse(widget.balance.toString()) ?? 0.0;
    _walletController.balance.value = initialBalance;
    _balanceController.text = initialBalance.toString();

    _walletController.selectedAccountName.value =
        widget.name != null && _walletController.banks.contains(widget.name)
            ? widget.name!
            : "Select Wallet";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _walletController.dispose();
    _balanceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: 'Add new Wallet',
        backGroundCol: ColorManager.primary,
        iconColor: Colors.white,
        textColor: Colors.white,
        onBack: () async {
          FocusScope.of(context).unfocus();
          await Future.delayed(const Duration(milliseconds: 300));
          Get.back();
        },
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '₹',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          height: 0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: size.width / 100),
                    CommonStyles.buildBalanceTextField(
                      size,
                      _balanceController,
                      _walletController.balance,
                    ),
                  ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height / 40),
                  _buildTextField(
                      size, 'Wallet Name', _walletController.walletName),
                  SizedBox(height: size.height / 40),
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      value: _walletController.banks.contains(
                              _walletController.selectedAccountName.value)
                          ? _walletController.selectedAccountName.value
                          : null,
                      decoration:
                          CommonStyles.inputDecoration('Select Wallet', size),
                      items: _walletController.banks
                          .map((bank) =>
                              DropdownMenuItem(value: bank, child: Text(bank)))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          _walletController.changeSelectedAccount(value);
                        }
                      },
                    );
                  }),
                  SizedBox(height: size.height / 20),
                  _buildBankIcons(size),
                  const Spacer(),
                  CustomButton(
                    text: 'Continue',
                    colorButton: ColorManager.primary,
                    colorText: ColorManager.lightBackground,
                    onTap: () async {
                      _walletController.balance.value =
                          double.tryParse(_balanceController.text) ?? 0.0;
                      if (double.parse(_balanceController.text) > 0) {
                        await _walletController
                            .saveWalletToFirebase()
                            .then((onValue) async {
                          Get.offAll(() => const AddAccountSuccessScreen());
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(Size size, String hintText, RxString value) {
    return Obx(() => TextFormField(
          readOnly: true,
          enabled: false,
          initialValue: value.value,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: CommonStyles.inputDecoration(hintText, size),
          cursorColor: ColorManager.primary,
          onChanged: (val) {
            value.value = val;
          },
        ));
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
      itemCount: _walletController.banks.length,
      itemBuilder: (context, index) {
        String bankName = _walletController.banks[index];
        return GestureDetector(
          onTap: () {
            _walletController.changeSelectedAccount(bankName);
          },
          child: Obx(() => Container(
                width: size.width / 4.5,
                height: size.height / 20,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _walletController.selectedAccountName.value == bankName
                      ? Colors.blue.withOpacity(0.2)
                      : const Color(0xFFF1F1FA),
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Image.asset(_walletController.bankLogos[index],
                        height: 24)),
              )),
        );
      },
    );
  }
}
