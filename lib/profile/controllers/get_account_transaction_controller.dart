import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetAccountTransactionController extends GetxController{
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxList transactionsList = [].obs;

  Future getAccountTransactions(String accountName) async {
    try {
      if (user != null) {
        fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions').where('fromAccountType',isEqualTo:accountName )
            .snapshots()
            .listen((snapShot) {
          List<Map<String, dynamic>> tempList = [];
          for (var doc in snapShot.docs) {
            Map<String, dynamic> data = doc.data();
            
            print("Fetched Transaction: $data");

            tempList.add(data);

          }

          transactionsList.value = tempList;
       
        });
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

}