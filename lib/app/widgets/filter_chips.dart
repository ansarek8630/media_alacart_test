import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/app_colors.dart';

class FilterChips extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  const FilterChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((opt) {
        final isSelected = opt == selected;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => onSelect(opt),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.searchBg : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF555555) : AppColors.cardBorder,
                ),
              ),
              child: Text(
                opt,
                style: TextStyle(
                  color: isSelected ? AppColors.textPrimary : AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}