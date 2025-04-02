import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxList transactionsList = [].obs;
  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpense = 0.0.obs;
  RxDouble totalTransfer = 0.0.obs;
  RxDouble totalBalance = 0.0.obs;
  RxString biggestIncomeCategory = "".obs;
  RxDouble biggestIncomeAmount = 0.0.obs;
  RxString biggestExpenseCategory = "".obs;
  RxDouble biggestExpenseAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future fetchTransactions() async {
    try {
      if (user != null) {
        fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions')
            .snapshots()
            .listen((snapShot) {
          List<Map<String, dynamic>> tempList = [];
          double income = 0.0;
          double expense = 0.0;
          double transfer = 0.0;

          Map<String, double> expenseCategoryMap = {};
          Map<String, double> incomeCategoryMap = {};

          for (var doc in snapShot.docs) {
            Map<String, dynamic> data = doc.data();
            tempList.add(data);

            if (data['type'] == 'Income') {
              double amount = data['amount'].toDouble();
              String category = data['category'];
              income += amount;

              incomeCategoryMap[category] =
                  (incomeCategoryMap[category] ?? 0) + amount;
            } else if (data['type'] == 'Expense') {
              double amount = data['amount'].toDouble();
              String category = data['category'];
              expense += amount;

              expenseCategoryMap[category] =
                  (expenseCategoryMap[category] ?? 0) + amount;
            } else if (data['type'] == 'Transfer') {
              transfer += data['amount'].toDouble();
              expenseCategoryMap["Transfer"] =
                  (expenseCategoryMap["Transfer"] ?? 0) +
                      data['amount'].toDouble();
            }
          }

          print("Expense Category Breakdown: $expenseCategoryMap");
          print("Income Category Breakdown: $incomeCategoryMap");

          if (expenseCategoryMap.isNotEmpty) {
            var maxEntry = expenseCategoryMap.entries
                .reduce((a, b) => a.value > b.value ? a : b);
            biggestExpenseCategory.value = maxEntry.key;
            biggestExpenseAmount.value = maxEntry.value;
          } else {
            biggestExpenseCategory.value = "N/A";
            biggestExpenseAmount.value = 0.0;
          }

          if (incomeCategoryMap.isNotEmpty) {
            var maxEntry = incomeCategoryMap.entries
                .reduce((a, b) => a.value > b.value ? a : b);
            biggestIncomeCategory.value = maxEntry.key;
            biggestIncomeAmount.value = maxEntry.value;
          } else {
            biggestIncomeCategory.value = "N/A";
            biggestIncomeAmount.value = 0.0;
          }

          transactionsList.value = tempList;
          totalIncome.value = income;
          totalExpense.value = expense + transfer;
          totalTransfer.value = transfer;
          totalBalance.value = income - (expense + transfer);
        });
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  Future deleteTransaction(String transactionId) async {
    try {
      if (user != null) {
        await fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions')
            .doc(transactionId)
            .delete();
      }
    } catch (e) {
      print("Error deleting transaction: $e");
    }
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

  Future<void> upDateTransaction({
    required String transactionId,
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
        CollectionReference reference = fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions');
        DocumentReference documentReference = reference.doc(transactionId);
        documentReference.update({
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
          else
            "repeat": FieldValue.delete(),
        });
      }
    } catch (e) {
      print("Error adding transaction: $e");
    }
  }

  Future fetchFilterTransaction(
      String category, String type, String sortBy) async {
    try {
      if (user != null) {
        CollectionReference reference = fireStore
            .collection('users')
            .doc(user!.uid)
            .collection('transactions');

        Query query = reference
            .where("category", isEqualTo: category)
            .where("type", isEqualTo: type)
            .orderBy("date", descending: true);

        QuerySnapshot snapshot = await query.get();
        transactionsList.assignAll(snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    }
  }
}
