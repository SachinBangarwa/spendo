import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FinancialReportController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  RxList incomeList = [].obs;
  RxList expenseList = [].obs;
  RxMap<String, double> categoryIncomeMap = <String, double>{}.obs;
  RxMap<String, double> categoryExpenseMap = <String, double>{}.obs;

  var frequency = 'Year'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFilteredTransactions(frequency.value);
  }

  void updateFrequency(String newFrequency) {
    frequency.value = newFrequency;
    fetchFilteredTransactions(frequency.value);
  }

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
    } else if (filter == "Month") {
      startDate = DateTime(now.year, now.month, 1);
      endDate = DateTime(now.year, now.month + 1, 1);
    } else {
      startDate = DateTime(now.year, 1, 1);
      endDate = DateTime(now.year + 1, 1, 1);
    }

    try {
      if (user != null) {
        QuerySnapshot incomeSnapshot = await fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions')
            .where('type', isEqualTo: 'Income')
            .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
            .where('date', isLessThan: endDate.toIso8601String())
            .orderBy('date', descending: true)
            .get();

        incomeList.assignAll(incomeSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());

        QuerySnapshot expenseSnapshot = await fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions')
            .where('type', isEqualTo: 'Expense')
            .where('date', isGreaterThanOrEqualTo: startDate.toIso8601String())
            .where('date', isLessThan: endDate.toIso8601String())
            .orderBy('date', descending: true)
            .get();

        expenseList.assignAll(expenseSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());

        // ✅ Category-wise Amount निकालना
        updateCategoryWiseAmounts();
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    }
  }

  void updateCategoryWiseAmounts() {
    categoryIncomeMap.clear();
    categoryExpenseMap.clear();

    for (var transaction in incomeList) {
      String category = transaction['category'];
      double amount = (transaction['amount'] as num).toDouble();
      categoryIncomeMap[category] =
          (categoryIncomeMap[category] ?? 0) + amount;
    }

    for (var transaction in expenseList) {
      String category = transaction['category'];
      double amount = (transaction['amount'] as num).toDouble();
      categoryExpenseMap[category] =
          (categoryExpenseMap[category] ?? 0) + amount;
    }
  }
}
