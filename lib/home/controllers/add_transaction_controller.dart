import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddTransactionController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> addTransaction({
    required double amount,
    required String description,
    required String fromAccountId,
    required String fromAccountType,
    String? category,
    String? toAccountId,
    String? toAccountType,
    String? imageUrl,
    bool isRepeat = false,
    String? frequency,
    String? endDate,
    String? startDate,
    required String type,
  }) async {
    try {
      if (user != null) {
        CollectionReference reference = _fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions');
        DocumentReference documentReference = reference.doc();

        documentReference.set({
          "transactionId": documentReference.id,
          "amount": amount,
          "category": category,
          "description": description,
          "date": DateTime.now().toIso8601String(),
          "fromAccountId": fromAccountId,
          "fromAccountType": fromAccountType,
          "toAccountId": toAccountId,
          "toAccountType": toAccountType,
          "type": type,
          "userId": user!.uid,
          "imageUrl": imageUrl,
          if (isRepeat)
            "repeat": {
              "isRepeat": isRepeat,
              "frequency": frequency,
              "startDate": startDate,
              "endDate": endDate,
            }
        });
        print("Transaction added successfully!");
      }
    } catch (e) {
      print("Error adding transaction: $e");
    }
  }

  Future<String?> getAccountIdByName(String accountName) async {
    var querySnapshot = await _fireStore
        .collection('users')
        .doc(user!.uid)
        .collection('accounts')
        .where('name', isEqualTo: accountName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
    return '';
  }
}
