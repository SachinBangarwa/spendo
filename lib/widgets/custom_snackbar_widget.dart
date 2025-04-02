import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String title, String message, {bool isSuccess = true}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isSuccess ? Colors.green : Colors.black,
    colorText: Colors.white,
    borderRadius: 20,
    icon: Icon(
      isSuccess ? Icons.check_circle : Icons.error,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 300),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
