import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/profile/controllers/add_bank_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_button_widget.dart';
import '../../../widgets/common_appBar _widget.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({
    super.key,
    required this.name,
    required this.balance,
  });

  final dynamic balance;
  final String? name;

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final AddBankController _bankController = Get.put(AddBankController());
  final TextEditingController _balanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    double initialBalance = double.tryParse(widget.balance.toString()) ?? 0.0;
    _bankController.balance.value = initialBalance;
    _balanceController.text = initialBalance.toString();

    _bankController.selectedAccountType.value =
        widget.name != null && _bankController.banks.contains(widget.name)
            ? widget.name!
            : "Select Bank";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        title: 'Add new Account',
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
                      height: 0,
                      fontWeight: FontWeight.w600),
                ),
                Row(
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
                    SizedBox(
                      width: size.width / 100,
                    ),
                    CommonStyles.buildBalanceTextField(
                        size, _balanceController, _bankController.balance),
                  ],
                )
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
                  _buildTextField(
                    size,
                    'Bank Name',
                    _bankController.bankName,
                  ),
                  SizedBox(height: size.height / 40),
                  Obx(() => DropdownButtonFormField<String>(
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        value: _bankController.banks.contains(
                                _bankController.selectedAccountType.value)
                            ? _bankController.selectedAccountType.value
                            : null,
                        decoration:
                            CommonStyles.inputDecoration('Select Bank', size),
                        items: _bankController.banks
                            .map((bank) => DropdownMenuItem(
                                  value: bank,
                                  child: Text(bank),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _bankController
                              .changeSelectedAccount(value ?? "Select Bank");
                        },
                      )),
                  SizedBox(height: size.height / 20),
                  _buildBankIcons(size),
                  const Spacer(),
                  CustomButton(
                    text: 'Continue',
                    colorButton: ColorManager.primary,
                    colorText: ColorManager.lightBackground,
                    onTap: () async {
                      _bankController.balance.value =
                          double.tryParse(_balanceController.text) ?? 0.0;

                      await _bankController.saveBankToFirebase();
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
      itemCount: _bankController.banks.length,
      itemBuilder: (context, index) {
        String bankName = _bankController.banks[index];
        return GestureDetector(
          onTap: () {
            _bankController.changeSelectedAccount(bankName);
          },
          child: Obx(() => Container(
                width: size.width / 4.5,
                height: size.height / 20,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _bankController.selectedAccountType.value == bankName
                      ? Colors.blue.withOpacity(0.2)
                      : const Color(0xFFF1F1FA),
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: index == _bankController.banks.length - 1
                        ? const Text(
                            "See Other",
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 10),
                          )
                        : Image.asset(_bankController.bankLogos[index],
                            height: 24)),
              )),
        );
      },
    );
  }
}

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:spendo/commons/common_styles.dart';
// import 'package:spendo/theme/color_manager.dart';
// import 'package:spendo/widgets/custom_button_widget.dart';
// import '../../../widgets/common_appBar _widget.dart';
//
// class AddBankScreen extends StatefulWidget {
//   const AddBankScreen({super.key,required this.name,required this.balance,});
//
//
//   final dynamic balance;
//   final String? name;
//   @override
//   State<AddBankScreen> createState() => _AddBankScreenState();
// }
//
// class _AddBankScreenState extends State<AddBankScreen> {
//   final TextEditingController _walletNameController = TextEditingController(text:'Wallet' );
//   late TextEditingController _balanceController ;
//   String? selectedAccountType='Select Bank';
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     selectedAccountType = widget.name != null && banks.contains(widget.name)
//         ? widget.name
//         : null;
//     _balanceController= TextEditingController(text:widget.balance );
//   }
//
//   final List<String> banks = [
//     "Chase",
//     "PayPal",
//     "Citi",
//     "BofA",
//     "Jago",
//     "Mandiri",
//     "See Other"
//   ].toList();
//
//   final List<String> bankLogos = [
//     "assets/icons/Bank.png",
//     "assets/icons/Bank1.png",
//     "assets/icons/Bank2.png",
//     "assets/icons/Bank3.png",
//     "assets/icons/Bank4.png",
//     "assets/icons/Bank5.png",
//     ""
//   ];
// //   "State Bank of India (SBI)",
// //     "HDFC Bank",
// //     "ICICI Bank",
// //     "Punjab National Bank (PNB)",
// //     "Axis Bank",
// //     "Kotak Mahindra Bank",
// //     "Bank of Baroda",
// //     "Canara Bank",
// //     "Union Bank of India",
// //     "IndusInd Bank",
// //     "IDBI Bank",
// //     "IDFC FIRST Bank",
// //     "Federal Bank",
// //     "South Indian Bank",
// //     "Yes Bank",
// //     "RBL Bank",
// //     "UCO Bank",
// //     "Indian Bank",
// //     "Central Bank of India",
// //     "Bank of India"
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: ColorManager.primary,
//       resizeToAvoidBottomInset: false,
//       appBar: CommonAppBar(
//         title: 'Add new Account',
//         backGroundCol: ColorManager.primary,
//         iconColor: Colors.white,
//         textColor: Colors.white,
//         onBack: () async {
//           FocusScope.of(context).unfocus();
//           await Future.delayed(const Duration(milliseconds: 300));
//           Get.back();
//         },
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width / 22),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Balance",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       '₹',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 40,
//                           height: 0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       width: size.width / 100,
//                     ),
//                     CommonStyles.buildBalanceTextField(size, _balanceController!,RxDouble(0.0)),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Container(
//             height: size.height / 1.8,
//             width: size.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(size.width / 12),
//                 topRight: Radius.circular(size.width / 12),
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: size.width / 22, vertical: size.height / 55),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: size.height / 40,
//                   ),
//                   _buildTextField(size, _walletNameController, 'Wallet Name'),
//                   SizedBox(height: size.height / 40),
//                   DropdownButtonFormField<String>(
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
//                     value: selectedAccountType,
//                     decoration: CommonStyles.inputDecoration('Select Bank', size),
//                     items: banks
//                         .map((bank) => DropdownMenuItem(value: bank, child: Text(bank)))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedAccountType = value;
//                       });
//                     },
//                   ),
//
//                   SizedBox(height: size.height / 20),
//                   _buildBankIcons(size),
//                   Spacer(),
//                   CustomButton(
//                     text: 'Continue',
//                     colorButton: ColorManager.primary,
//                     colorText: ColorManager.lightBackground,
//                     onTap: () async {
//                       try {
//                         double balance =
//                             double.tryParse(_balanceController.text) ?? 0.0;
//                         User? user = FirebaseAuth.instance.currentUser;
//
//                         if(user!=null){
//                           CollectionReference reference =
//                           FirebaseFirestore.instance
//                               .collection('users')
//                               .doc(user.uid)
//                               .collection('accounts');
//
//                           DocumentReference documentRef = reference.doc();
//
//                           await documentRef.set({
//                             'accountId': documentRef.id,
//                             'name': selectedAccountType,
//                             'type': 'Bank',
//                             'balance': balance,
//                             'createdAt': FieldValue.serverTimestamp(),
//                           });
//                         }
//
//                       } catch (e) {
//                         print('error:$e');
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField(
//       Size size, TextEditingController controller, String hintText) {
//     return TextFormField(
//       controller: controller,
//       style: const TextStyle(fontWeight: FontWeight.w600),
//       decoration: CommonStyles.inputDecoration(hintText, size),
//       cursorColor: ColorManager.primary,
//     );
//   }
//
//
//
//   Widget _buildBankIcons(Size size) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         crossAxisSpacing: size.width * 0.02,
//         mainAxisSpacing: size.height * 0.02,
//         childAspectRatio: (size.width / 4.5) / (size.height / 20),
//       ),
//       itemCount: banks.length,
//       itemBuilder: (context, index) {
//         print("Index: $index, Bank Name: ${banks[index]}"); // Debugging print
//
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedAccountType = banks[index];
//             });
//           },
//           child: Container(
//             width: size.width / 4.5,
//             height: size.height / 20,
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: selectedAccountType == banks[index]
//                   ? Colors.blue.withOpacity(0.2)
//                   : const Color(0xFFF1F1FA), // Default Background Color
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//                 child: index ==  banks.length - 1
//                     ? Text(
//                   "See Other",
//                   style: TextStyle(
//                       color: ColorManager.primary,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 10),
//                 )
//                     : Image.asset(bankLogos[index], height: 24)
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
