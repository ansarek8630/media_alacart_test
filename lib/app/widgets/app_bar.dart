import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuTap;

  const CustomAppBar({super.key, required this.title, this.onMenuTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBar,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.textPrimary),
        onPressed: onMenuTap,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune, color: AppColors.textMuted),
          onPressed: () {},
        ),
      ],
    );
  }
}