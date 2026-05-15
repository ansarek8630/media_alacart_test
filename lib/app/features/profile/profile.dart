import 'package:flutter/material.dart';
import 'package:media_alacart_test/core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
      ),
    );
  }
}
