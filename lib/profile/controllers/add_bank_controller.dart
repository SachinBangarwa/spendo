import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBankController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  RxString selectedAccountName = "SBI".obs;
  RxDouble balance = 0.0.obs;
  RxString bankName = "Bank".obs;

  RxList<String> banks = [
    "State Bank of India (SBI)",
    "HDFC Bank",
    "Punjab National Bank (PNB)",
    "ICICI Bank"
  ].obs;

  RxList<String> bankLogos = [
    "assets/icons/Bank.png",
    "assets/icons/Bank1.png",
    "assets/icons/Bank2.png",
    "assets/icons/Bank3.png",
  ].obs;

  void changeSelectedAccount(String account) {
    selectedAccountName.value = account;
  }

  Future<void> saveBankToFirebase() async {
    try {
      if (selectedAccountName.value != "Select Bank" &&
          bankName.isNotEmpty &&
          balance.value > 0) {
        if (user != null) {
          CollectionReference reference = FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .collection('accounts');

          QuerySnapshot querySnapshot = await reference
              .where('name', isEqualTo: selectedAccountName.value)
              .where('type', isEqualTo: 'Bank')
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            double newBalance = 0.0;
            String accountId = '';
            for (var doc in querySnapshot.docs) {
              double existingBalance = (doc['balance'] ?? 0).toDouble();
              newBalance = existingBalance + balance.value;
              accountId = doc['accountId'] ?? '';
            }
            await reference.doc(accountId).update({
              'balance': newBalance,
              'updatedAt': FieldValue.serverTimestamp(),
            });
          } else {
            DocumentReference documentRef = reference.doc();

            await documentRef.set({
              'accountId': documentRef.id,
              'name': selectedAccountName.value,
              'type': 'Bank',
              'balance': balance.value,
              'createdAt': FieldValue.serverTimestamp(),
            });
          }
        }
      }
    } catch (e) {
      print('Error saving bank: $e');
    }
  }

  Future updateBank(String accountId) async {
    try {
      if (user != null) {
        CollectionReference reference = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('accounts');

        await reference.doc(accountId).update({
          'name': selectedAccountName.value,
          'balance': balance.value,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {}
  }

  Future removeBank(String accountId) async {
    try {
      if (user != null) {
        CollectionReference reference = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('accounts');

        await reference.doc(accountId).delete();
      }
    } catch (e) {}
  }
}
