import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color colorButton;
  final Color colorText;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.colorButton,
    required this.colorText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: size.width,
        height: size.height / 14,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorButton,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
