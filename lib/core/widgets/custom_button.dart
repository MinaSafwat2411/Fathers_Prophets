import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isEnabled,
      required this.btnColor,
      required this.height,
      required  this.isDark});
  final VoidCallback onPressed;
  final String text;
  final Color btnColor;
  final double height;
  final bool isEnabled ;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: isEnabled? onPressed : (){},
        color: isEnabled? btnColor : AppColors.gray,
        child: Text(
          text,
          style:  textTheme.bodyLarge?.copyWith(color: isDark? AppColors.mirage : AppColors.white),
        ),
      ),
    );
  }
}
