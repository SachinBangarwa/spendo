import 'package:get/get.dart';

class AddAccountController extends GetxController {
  RxString selectedAccountType = 'Bank'.obs;

  void changeDropValue(String value) {
    selectedAccountType.value = value;
  }
}