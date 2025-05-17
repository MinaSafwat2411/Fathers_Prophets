import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';

class HomeShimmerItem extends StatelessWidget {
  const HomeShimmerItem({super.key,required this.isDark});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isDark? AppColors.riverBed:AppColors.gray,
      highlightColor: AppColors.white,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.gray20,
        ),
      ),
    );
  }
}
