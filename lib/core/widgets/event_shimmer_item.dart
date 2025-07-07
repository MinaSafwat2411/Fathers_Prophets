import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';

class EventShimmerItem extends StatelessWidget {
  const EventShimmerItem({super.key,required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isDark? AppColors.riverBed:AppColors.gray,
      highlightColor: AppColors.white,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.gray20,
        ),
      ),
    );
  }
}
