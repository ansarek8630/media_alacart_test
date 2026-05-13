import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/app_colors.dart';

class CampaignSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const CampaignSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.searchBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textMuted, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search Campaigns...',
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const Icon(Icons.tune, color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}