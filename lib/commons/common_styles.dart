import 'package:flutter/material.dart';
import 'package:spendo/theme/color_manager.dart';

class CommonStyles {
  static InputDecoration inputDecoration(String hintText, Size size) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black87
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: size.width / 20, vertical: size.height / 46),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue), // Change primary color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFFDEEDB), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManager.primary, width: 2),
      ),
    );
  }
}
