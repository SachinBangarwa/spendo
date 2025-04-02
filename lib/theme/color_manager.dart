import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xFF7F3DFF);

  static const Color lightBackground = Colors.white;
  static const Color lightCard = Color(0xFFFFCC80);
  static const Color lightText = Colors.black;

  static const Color darkBackground = Colors.black;
  static const Color darkCard = Color(0xFFE65100);
  static const Color darkText = Colors.white;

  static Color getCategoryColor(String category) {
    switch (category) {
      case "Salary":
        return const Color(0xFF00A86B);
      case "Freelance":
        return const Color(0xFF087E8B);
      case "Investments":
        return const Color(0xFF004AAD);
      case "Gifts":
        return const Color(0xFFA12A5E);
      case "Business":
        return const Color(0xFF0D0E0F);

      case "Food & Drinks":
        return const Color(0xFFFD3C4A);
      case "Shopping":
        return const Color(0xFFFCAC12);
      case "Transport":
        return const Color(0xFF7F3DFF);
      case "Entertainment":
        return const Color(0xFF5727A3);
      case "Health & Fitness":
        return const Color(0xFF1FAA59);

      default:
        return const Color(0xFF5A5A5A);
    }
  }
}
