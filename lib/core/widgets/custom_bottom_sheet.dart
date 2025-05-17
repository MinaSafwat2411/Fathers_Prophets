import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class CustomBottomSheet extends StatelessWidget {
  final String title;
  final bool isDark;
  final Widget widget;

  // ignore: use_super_parameters
  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.isDark,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.gray20,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                  letterSpacing: -0.45,
                ),
              ),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.gray20,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text('x'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          widget
        ],
      ),
    );
  }
}
