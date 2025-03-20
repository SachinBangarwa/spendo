import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBankController extends GetxController {
  RxString selectedAccountType = "Chase".obs;
  RxDouble balance = 0.0.obs;
  RxString bankName = "Bank".obs;

  RxList<String> banks = [
    "Select Bank",
    "Chase",
    "PayPal",
    "Citi",
    "BofA",
    "Jago",
    "See Other"
  ].obs;

  RxList<String> bankLogos = [
    "assets/icons/Bank.png",
    "assets/icons/Bank1.png",
    "assets/icons/Bank2.png",
    "assets/icons/Bank3.png",
    "assets/icons/Bank4.png",
    "assets/icons/Bank5.png",
    ""
  ].obs;

  void changeSelectedAccount(String account) {
    selectedAccountType.value = account;
  }

  Future<void> saveBankToFirebase() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (selectedAccountType.value != "Select Bank" &&
          bankName.isNotEmpty &&
          balance.value > 0) {
        if (user != null) {
          CollectionReference reference = FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('accounts');

          DocumentReference documentRef = reference.doc();

          await documentRef.set({
            'accountId': documentRef.id,
            'name': selectedAccountType.value,
            'type': 'Bank',
            'balance': balance.value,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      print('Error saving bank: $e');
    }
  }
}
