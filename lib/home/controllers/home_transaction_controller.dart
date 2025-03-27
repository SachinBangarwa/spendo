import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeTransactionController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxList transactionsList = [].obs;

  Future<void> fetchFilteredTransactions(String filter) async {
    DateTime now = DateTime.now();
    DateTime startDate, endDate;

    if (filter == "Today") {
      startDate = DateTime(now.year, now.month, now.day);
      endDate = startDate.add(const Duration(days: 1));
    } else if (filter == "Yesterday") {
      startDate = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 1));
      endDate = startDate.add(const Duration(days: 1));
    } else if (filter == "Week") {
      int currentWeekday = now.weekday;
      startDate = now.subtract(Duration(days: currentWeekday - 1));
      endDate = startDate.add(const Duration(days: 7));
    } else if (filter == "Monthly") {
      startDate = DateTime(now.year, now.month, 1);
      endDate = DateTime(now.year, now.month + 1, 1);
    } else {
      startDate = DateTime(now.year, 1, 1);
      endDate = DateTime(now.year + 1, 1, 1);
    }

    try {
      if (user != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('transactions')
            .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
            .where('date', isLessThan: endDate.toIso8601String())
            .orderBy('date', descending: true)
            .get();

        transactionsList.assignAll(snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
      }
    } catch (e) {}
  }


}