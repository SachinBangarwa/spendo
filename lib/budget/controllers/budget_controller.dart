import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';

class BudgetController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  RxBool checkBox = false.obs;
  RxDouble sliderValue = 80.0.obs;

  void toggleAlert(bool value) {
    checkBox.value = value;
  }

  void updateSlider(double value) {
    sliderValue.value = value;
  }

  Future<void> saveBudget(String category, String amount) async {
    try {
      if (user != null) {
        CollectionReference budgetsRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('budgets');

        CollectionReference expensesRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('transactions');

        QuerySnapshot existingExpense = await expensesRef
            .where('category', isEqualTo: category)
            .limit(1)
            .get();

        if (existingExpense.docs.isEmpty) {
          showCustomSnackBar('Error',
              "You need to add an expense before setting a budget for this category.",
              isSuccess: false);
          return;
        }

        QuerySnapshot existingBudget = await budgetsRef
            .where('category', isEqualTo: category)
            .limit(1)
            .get();

        if (existingBudget.docs.isNotEmpty) {
          String docId = existingBudget.docs.first.id;
          await budgetsRef.doc(docId).update({
            'amount': double.parse(amount),
            'alertEnabled': checkBox.value,
            'alertPercentage': sliderValue.value,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {
          DocumentReference newBudgetRef = await budgetsRef.add({
            'budgetId': "",
            'amount': double.parse(amount),
            'category': category,
            'alertEnabled': checkBox.value,
            'alertPercentage': sliderValue.value,
            'createdAt': FieldValue.serverTimestamp(),
          });

          await newBudgetRef.update({'budgetId': newBudgetRef.id});
        }
      }
    } catch (e) {}
  }

  Future<void> updateBudget(
      String budgetId, String category, String amount) async {
    try {
      if (user != null) {
        CollectionReference budgetsRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('budgets');

        await budgetsRef.doc(budgetId).update({
          'amount': double.parse(amount),
          'category': category,
          'alertEnabled': checkBox.value,
          'alertPercentage': sliderValue.value,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        showCustomSnackBar('Success', "Budget updated successfully!",
            isSuccess: true);
      }
    } catch (e) {
      showCustomSnackBar('Error', "Failed to update budget: $e",
          isSuccess: false);
    }
  }

  Future deleteBudget(String id) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('budgets')
            .doc(id)
            .delete();
        showCustomSnackBar(
          'Success',
          'Budget deleted successfully!',
        );
      }
    } catch (e) {}
  }
}
