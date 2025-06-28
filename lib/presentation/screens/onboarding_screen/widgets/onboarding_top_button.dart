import 'package:flutter/material.dart';

import '../../../../core/widgets/indicators.dart';


class OnboardingTopButton extends StatelessWidget {
  const OnboardingTopButton({super.key,required this.isDark,required this.index,this.total});

  final bool isDark;
  final int index;
  final int? total;

  @override
  Widget build(BuildContext context) {
    return Indicators(index: index,isDark: isDark,total: total,);
  }
}
