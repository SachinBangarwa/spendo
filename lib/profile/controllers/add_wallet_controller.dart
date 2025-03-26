import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddWalletController extends GetxController {
  RxString walletName = "Wallet".obs;
  RxDouble balance = 0.0.obs;
  RxString selectedAccountName = "".obs;
  User? user = FirebaseAuth.instance.currentUser;

  RxList<String> banks = [
    "Paytm Wallet",
    "Google Pay Wallet",
    "PhonePe Wallet",
    "Amazon Pay Wallet"
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

  @override
  void onInit() {
    super.onInit();
    if (banks.isNotEmpty) {
      selectedAccountName.value = banks.first;
    }
  }

  Future<void> saveWalletToFirebase() async {
    try {
      if (user != null) {
        CollectionReference reference = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('accounts');

        QuerySnapshot querySnapshot = await reference
            .where('name', isEqualTo: selectedAccountName.value)
            .where('type', isEqualTo: 'Wallet')
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
            'type': 'Wallet',
            'balance': balance.value,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      print('Error saving wallet: $e');
    }
  }

  Future updateWallet(String accountId) async {
    try {
      if (user != null) {
        CollectionReference reference = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('accounts');

    await    reference.doc(accountId).update({
          'name': selectedAccountName.value,
          'balance': balance.value,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {}
  }
  Future removeWallet(String accountId) async {
    try {
      if (user != null) {
        CollectionReference reference = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('accounts');

    await    reference.doc(accountId).delete();
      }
    } catch (e) {}
  }
}
