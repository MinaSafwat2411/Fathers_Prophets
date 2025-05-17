import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key,required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.transparent,
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 1,
              backgroundColor: AppColors.transparent,
              color: isDark? AppColors.white: AppColors.mirage
          ),
        )
    );
  }
}
