import 'package:flutter/material.dart';

import '../../../../core/widgets/indicators.dart';


class OnboardingTopButton extends StatelessWidget {
  const OnboardingTopButton({super.key,required this.isDark,required this.index});

  final bool isDark;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Indicators(index: index,isDark: isDark,);
  }
}
