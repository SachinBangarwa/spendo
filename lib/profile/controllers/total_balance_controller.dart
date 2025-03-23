import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TotalBalanceController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  RxDouble totalBalance = 0.0.obs;
  RxList<Map<String, dynamic>> accountsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    totalBalanceCloud();
  }

  void totalBalanceCloud() {
  try{
    if (user == null) return;

    fireStore
        .collection('users')
        .doc(user!.uid)
        .collection('accounts')
        .snapshots()
        .listen((snapshot) {
      double total = 0.0;
      List<Map<String, dynamic>> tempList = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();
        total += (data['balance'] ?? 0).toDouble();
        tempList.add(data);
      }

      totalBalance.value = total;
      accountsList.value = tempList;
    });
  }catch(e){
    print('object=>$e');
  }
  }
}
