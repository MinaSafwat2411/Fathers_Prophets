import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key, required this.currentScreen});

  final int currentScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {},
              child: Column(
                children: [
                  if (currentScreen == 0)
                    Container(
                        height: 35,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.mirage),
                        child: const Icon(Icons.home, color: AppColors.white))
                  else
                    const Icon(Icons.home, color: AppColors.mirage),
                  const Text("Home",
                      style: TextStyle(color: AppColors.mirage, fontSize: 12))
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Column(
                children: [
                  if (currentScreen == 1)
                    Container(
                        height: 35,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.mirage),
                        child: const Icon(Icons.home, color: AppColors.white))
                  else
                    const Icon(Icons.home, color: AppColors.mirage),
                  const Text("Home",
                      style: TextStyle(color: AppColors.mirage, fontSize: 12))
                ],
              ),
            ),
            const SizedBox(),
            MaterialButton(
              onPressed: () {},
              child: Column(
                children: [
                  if (currentScreen == 2)
                    Container(
                        height: 35,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.mirage),
                        child: const Icon(Icons.home, color: AppColors.white))
                  else
                    const Icon(Icons.home, color: AppColors.mirage),
                  const Text("Home",
                      style: TextStyle(color: AppColors.mirage, fontSize: 12))
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Column(
                children: [
                  if (currentScreen == 3)
                    Container(
                        height: 35,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.mirage),
                        child: const Icon(Icons.home, color: AppColors.white))
                  else
                    const Icon(Icons.home, color: AppColors.mirage),
                  const Text("Home",
                      style: TextStyle(color: AppColors.mirage, fontSize: 12))
                ],
              ),
            )
          ]),
    );
  }
}
