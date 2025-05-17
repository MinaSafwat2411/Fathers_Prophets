import 'package:flutter/material.dart';


class CustomBottomNavigationBarItem {
  static BottomNavigationBarItem create({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      activeIcon: Container(
        width: 55,
        height: 35,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Icon(
          icon,
        ),
      ),
      label: label,
    );
  }
}
