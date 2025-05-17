import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomBigTextField extends StatelessWidget {
  const CustomBigTextField({
    super.key,
    this.label,
    required this.controller,
    required this.isDark,
    required this.observe,
    this.validator,
  });

  final String? label;
  final TextEditingController controller;
  final bool isDark;
  final String? Function(String?)? validator;
  final bool observe;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mirage2,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 55,
      child: TextFormField(
        style: const TextStyle(
          color: AppColors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
          hintText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
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
          fillColor: AppColors.white,
        ),
        autofocus: false,
        maxLines: 1,
        cursorColor: AppColors.white,
        validator: validator,
        obscureText: observe ? true : false,
      ),
    );
  }
}
