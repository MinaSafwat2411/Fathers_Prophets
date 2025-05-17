import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

void showCustomSnackBar(BuildContext context, String message, {IconData? icon,Color? color}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        if (icon != null) Icon(icon, color: Colors.white), // Optional icon
        const SizedBox(width: 10), // Spacing
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ],
    ),
    backgroundColor: color, // Change as per theme
    behavior: SnackBarBehavior.floating, // Floating style
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: const Duration(seconds: 3),
    showCloseIcon: true,
    closeIconColor: AppColors.mirage,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
