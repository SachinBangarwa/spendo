import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../theme/color_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController =
  TextEditingController(text: "₹");
  String? selectedAccountType;
  bool isBalanceEditable = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: size.height / 10,
        backgroundColor: ColorManager.primary,
        leading: GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              await Future.delayed(Duration(milliseconds: 300));
              Get.back();
            },
            child: const Icon(
              Icons.keyboard_backspace_outlined,
              color: Colors.white,
              size: 32,
            )),
        title: const Text(
          'Add New Account',
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

                // 🔹 Pehle sirf balance text dikhega, jab user click karega to editable field ban jayega
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isBalanceEditable = true;
                    });
                  },
                  child: isBalanceEditable
                      ? _buildBalanceTextField(size, _balanceController)
                      : Text(
                    _balanceController.text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height / 2.6,
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
                  SizedBox(height: size.height / 35),
                  _buildTextField(size, _nameController, 'Name'),
                  SizedBox(height: size.height / 35),
                  DropdownButtonFormField<String>(
                    value: selectedAccountType,
                    decoration:
                    CommonStyles.inputDecoration('Account Type', size),
                    items: ["Bank", "Credit Card", "Wallet"]
                        .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAccountType = value;
                      });
                    },
                  ),
                  Spacer(),
                  CustomButton(
                    text: 'Continue',
                    colorButton: ColorManager.primary,
                    colorText: ColorManager.lightBackground,
                    onTap: () async {
                   try{
                     String name = _nameController.text.trim();
                     double balance =
                         double.tryParse(_balanceController.text) ?? 0.0;
                     User? user = FirebaseAuth.instance.currentUser;

                     if (user == null) {
                       print("User not logged in!");
                       return;
                     }else{
                       print('yes');
                     }

                     CollectionReference reference = FirebaseFirestore.instance
                         .collection('users')
                         .doc(user.uid) // ✅ Ensure user ID is correct
                         .collection('accounts');

                     DocumentReference documentRef = reference.doc();

                     await documentRef.set({
                       'accountId': documentRef.id,  // ❗ document ID ko store karo, not the reference
                       'name': name,
                       'type': selectedAccountType ?? 'Bank',
                       'balance': balance,
                       'createdAt': FieldValue.serverTimestamp(),
                     });
                   }catch(e){

                     print('error:$e');
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

  Widget _buildTextField(
      Size size, TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: CommonStyles.inputDecoration(hintText, size),
      cursorColor: ColorManager.primary,
    );
  }

  // 🔹 Editable Balance Field
  Widget _buildBalanceTextField(
      Size size, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      cursorColor: Colors.white,
      textAlign: TextAlign.start,
    );
  }
}
