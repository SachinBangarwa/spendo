import 'package:flutter/material.dart';

import '../commons/common_styles.dart';

class CommonDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String hintText;
  final Size size;
  final Color? borderColor;

  const CommonDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
    required this.size,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      decoration:
      CommonStyles.inputDecoration(hintText, size, borderColor: borderColor),
      items: [
        DropdownMenuItem<String>(
          value: null,
          child: Text(
            hintText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        ...items.map((type) => DropdownMenuItem(value: type, child: Text(type))),
      ],
      onChanged: onChanged,
    );
  }
}
