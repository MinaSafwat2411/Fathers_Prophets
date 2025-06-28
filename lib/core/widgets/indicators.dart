import 'package:fathers_prophets/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Indicators extends StatelessWidget {
   const Indicators({super.key,required this.index,required this.isDark,this.total});

  final int index;
  final bool isDark;
  final int? total;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < (total??4); i++)
                Container(
                  width: total == 4? 85:(MediaQuery.of(context).size.width/2)-35,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isDark?i<=index-1? AppColors.azureRadiance:AppColors.atlo :i<=index-1? AppColors.mirage:AppColors.atlo,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < (total??4)+1; i++)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isDark? i<=index? AppColors.azureRadiance:AppColors.atlo :i<=index? AppColors.mirage:AppColors.atlo,
                  ),
                ),
            ],
          ),
        ),

      ],
    );
  }
}
