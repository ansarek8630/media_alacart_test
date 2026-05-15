import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../data/models/campaign_list_model.dart';


class CampaignCard extends StatelessWidget {
  final Campaign campaign;

  const CampaignCard({Key? key, required this.campaign}) : super(key: key);

  String _formatNumber(int number) {
    if (number >= 1000000) return '${(number / 1000000).toStringAsFixed(1)}M';
    if (number >= 1000) return '${(number / 1000).toStringAsFixed(1)}K';
    return number.toString();
  }

  Color _getStatusColor() {
    switch (campaign.status.toLowerCase()) {
      case 'active': return AppColors.statusActive;
      case 'paused': return AppColors.statusPaused;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,##0', 'en_US');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.campaign, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(campaign.name, style: AppTextStyles.title),
                    const SizedBox(height: 4),
                    Text(campaign.objective, style: AppTextStyles.badgeText.copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(radius: 3, backgroundColor: _getStatusColor()),
                    const SizedBox(width: 4),
                    Text(campaign.status, style: AppTextStyles.body.copyWith(color: _getStatusColor(), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.more_horiz, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 20),

          // Spend Progress
          Text('Total spend', style: AppTextStyles.body),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('${currencyFormat.format(campaign.spend)} ${campaign.currency}', style: AppTextStyles.h1.copyWith(fontSize: 16)),
              Text(' / ${currencyFormat.format(campaign.budget)} ${campaign.currency}', style: AppTextStyles.body),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: campaign.budgetUtilizationPercentage,
                    backgroundColor: AppColors.surfaceLight,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('${(campaign.budgetUtilizationPercentage * 100).toInt()}%', style: AppTextStyles.body),
            ],
          ),
          const SizedBox(height: 20),

          // Stats Grid
          Row(
            children: [
              _buildStatBox('Impressions', _formatNumber(campaign.impressions), Icons.visibility),
              const SizedBox(width: 8),
              _buildStatBox('Clicks', _formatNumber(campaign.clicks), Icons.ads_click),
              const SizedBox(width: 8),
              _buildStatBox('CTR', '${campaign.clientCalculatedCtr.toStringAsFixed(2)}%', Icons.trending_up),
            ],
          ),
          const SizedBox(height: 16),

          // Footer info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFooterInfo(Icons.calendar_month, 'Start date', campaign.startDate?.toIso8601String() ?? ''),
              _buildFooterInfo(Icons.radar, 'Audience', campaign.channel),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceLight),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(height: 8),
            Text(value, style: AppTextStyles.highlightNumber),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.body.copyWith(fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.body.copyWith(fontSize: 10)),
            Text(value, style: AppTextStyles.subtitle1),
          ],
        ),
      ],
    );
  }
}