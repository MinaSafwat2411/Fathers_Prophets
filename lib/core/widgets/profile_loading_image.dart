import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';

class ProfileLoadingImage extends StatelessWidget {
  const ProfileLoadingImage({super.key,required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isDark? AppColors.riverBed:AppColors.gray,
      highlightColor: AppColors.white,
      child: Container(
        height: 36,
        width: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gray20,
        ),
      ),
    );
  }
}
