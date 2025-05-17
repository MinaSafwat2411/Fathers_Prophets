import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class OnboardingBottomButton extends StatelessWidget {
  const OnboardingBottomButton({
    super.key,
    required this.pageController,
    required this.title,
    required this.function,
    required this.isDark,
    required this.lang,
    required this.text,
    required this.skip,
  });

  final PageController pageController;
  final String title;
  final GestureTapCallback function;
  final GestureTapCallback skip;
  final bool isDark;
  final String lang;
  final String text;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextButton(
            onPressed: function,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: AppColors.mirage, width: 2),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(title, style: textTheme.titleLarge),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: GestureDetector(
              onTap: skip,
              child: Text(
                text,
                style:textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
