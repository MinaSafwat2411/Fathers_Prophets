import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomBigTextField extends StatelessWidget {
  CustomBigTextField({
    super.key,
    this.label,
    required this.controller,
    required this.isDark,
    required this.observe,
    this.validator,
    this.onChanged,
    this.icon,
    this.keyboardType,
    this.enable = true,
  });

  final String? label;
  final TextEditingController controller;
  final bool isDark;
  final String? Function(String?)? validator;
  final bool observe;
  final void Function(String)? onChanged;
  Widget? icon;
  final TextInputType? keyboardType;
  bool enable = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: TextFormField(
        enabled: enable,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style:  TextStyle(
          color: isDark ? AppColors.white:AppColors.mirage,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintStyle:  TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.white:AppColors.mirage,
          ),
          hintText: label,
          suffix: icon,
          labelStyle:  TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.mirage:AppColors.white,
          ),
          floatingLabelStyle: const TextStyle(
            color: AppColors.white,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.azureRadiance),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.azureRadiance),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.azureRadiance),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.azureRadiance),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          counterStyle: TextStyle(
            color: AppColors.white
          ),
          filled: false,
        ),
        autofocus: false,
        maxLines: 1,
        cursorColor: isDark ? AppColors.white:AppColors.mirage,
        validator: validator,
        obscureText: observe ? true : false,
      ),
    );
  }
}
