import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';
import 'home_shimmer_item.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key,required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      child: Shimmer.fromColors(
                        baseColor: isDark? AppColors.riverBed:AppColors.gray,
                        highlightColor: AppColors.white,
                        child: Container(
                          height: 40,
                          width: 180,
                          decoration: const BoxDecoration(color: AppColors.gray20),
                        ),),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      height: 150,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => HomeShimmerItem(isDark: isDark),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              ),
              separatorBuilder: (context, index) =>const SizedBox(
                height: 15,
              ),
              itemCount: 4
          ),
        )
      ],
    );
  }
}
