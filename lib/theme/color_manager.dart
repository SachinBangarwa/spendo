import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xFF7F3DFF);

  static const Color lightBackground = Colors.white;
  static const Color lightCard = Color(0xFFFFCC80);
  static const Color lightText = Colors.black;

  static const Color darkBackground = Colors.black;
  static const Color darkCard = Color(0xFFE65100);
  static const Color darkText = Colors.white;


static  Color getCategoryColor(String category) {
    switch (category) {
    // Income Categories
      case "Salary":
        return Color(0xFF00A86B); // Deep Green
      case "Freelance":
        return Color(0xFF087E8B); // Teal Blue
      case "Investments":
        return Color(0xFF004AAD); // Royal Blue
      case "Gifts":
        return Color(0xFFA12A5E); // Deep Pinkish Purple
      case "Business":
        return Color(0xFF0D0E0F); // Dark Grey/Black

    // Expense Categories
      case "Food & Drinks":
        return Color(0xFFFD3C4A); // Bright Red
      case "Shopping":
        return Color(0xFFFCAC12); // Deep Orange-Yellow
      case "Transport":
        return Color(0xFF7F3DFF); // Rich Purple
      case "Entertainment":
        return Color(0xFF5727A3); // Deep Violet
      case "Health & Fitness":
        return Color(0xFF1FAA59); // Bright Green

    // Default (Other Expenses)
      default:
        return Color(0xFF5A5A5A); // Dark Grey
    }
  }

}
