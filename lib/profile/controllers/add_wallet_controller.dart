import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddWalletController extends GetxController {
  RxString walletName = "Wallet".obs;
  RxDouble balance = 0.0.obs;
  RxString selectedAccountType = "Cash".obs;
  User? user = FirebaseAuth.instance.currentUser;

  RxList<String> banks = [
    "Cash",
    "Paytm Wallet",
    "Google Pay",
    "PhonePe",
    "Amazon Pay",
    "Airtel Money",
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

  Future<void> saveWalletToFirebase() async {
    try {
       if (user != null) {
         CollectionReference reference = FirebaseFirestore.instance
             .collection('users')
             .doc(user!.uid)
             .collection('accounts');

         DocumentReference documentRef = reference.doc();

         await documentRef.set({
           'accountId': documentRef.id,
           'name': selectedAccountType.value,
           'type': 'Wallet',
           'balance': balance.value,
           'createdAt': FieldValue.serverTimestamp(),
         });
       }
    } catch (e) {
      print('Error saving wallet: $e');
    }
  }
}
