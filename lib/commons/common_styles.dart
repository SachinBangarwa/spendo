import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonStyles {
  static InputDecoration inputDecoration(
      String hintText,
      Size size, {
        Color? borderColor,
      }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      contentPadding: EdgeInsets.symmetric(
          horizontal: size.width / 20, vertical: size.height / 46),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: borderColor ?? Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide:
        BorderSide(color: borderColor?.withOpacity(0.2) ?? const Color(0xFFD6CDE4), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide:
        BorderSide(color: borderColor ?? const Color(0xFF7F3DFF), width: 2),
      ),
    );
  }

  static Widget buildBalanceTextField(Size size, TextEditingController controller, RxDouble balance) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        onChanged: (value) {
          balance.value = double.tryParse(value) ?? 0.0;
        },
      ),
    );
  }

}
