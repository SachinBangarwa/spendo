
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final VoidCallback? onTrailingTap;
  final Color? iconColor;
  final Color? backGroundCol;
  final Color? textColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
    this.onTrailingTap,
    this.iconColor,
    this.backGroundCol,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backGroundCol ?? Colors.white,
      toolbarHeight: MediaQuery.of(context).size.height / 10,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: GestureDetector(
          onTap: onBack,
          child: Icon(
            Icons.keyboard_backspace_outlined,
            color: iconColor ?? Colors.black,
            size: 32,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor ?? const Color(0xFF212325)),
      ),
      centerTitle: true,
      actions: trailing != null
          ? [
              GestureDetector(
                onTap: onTrailingTap,
                child: trailing!,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
