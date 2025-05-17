import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';

class BookingShimmerItem extends StatelessWidget {
  const BookingShimmerItem({super.key,required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: isDark? AppColors.riverBed:AppColors.gray,
        highlightColor: AppColors.white,
        child: Container(
          height: 275,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.gray20,
          ),
        ),
      ),
    );
  }
}
