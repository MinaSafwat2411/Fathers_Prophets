import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Chat Bot',
          style: TextStyle(fontSize: 24, color: AppColors.mirage),
        ),
      ),
    );
  }
}
