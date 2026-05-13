import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import '../repository/campaign_model.dart';
import '../repository/campaign_status.dart';


class CampaignCard extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 10),
          _buildSpendRow(),
          const SizedBox(height: 6),
          _buildProgressBar(),
          const SizedBox(height: 10),
          _buildStats(),
          const SizedBox(height: 10),
          _buildMeta(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A35),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.campaign_outlined,
              color: AppColors.accent, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(campaign.name,
                  style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.3)),
              const SizedBox(height: 2),
              Text(campaign.type,
                  style: const TextStyle(
                      color: AppColors.typeLabel, fontSize: 11)),
            ],
          ),
        ),
        _StatusBadge(status: campaign.status),
      ],
    );
  }

  Widget _buildSpendRow() {
    return Row(
      children: [
        Text(
          '${campaign.totalSpend.toStringAsFixed(0)} SAR',
          style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(width: 4),
        Text(
          '/ ${campaign.budget.toStringAsFixed(0)} SAR',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    final color = campaign.status == CampaignStatus.paused
        ? AppColors.accentPaused
        : AppColors.accent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: campaign.progress,
            backgroundColor: AppColors.cardBorder,
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 4,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '${(campaign.progress * 100).toInt()}%',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        _StatCell(
          value: _formatCount(campaign.impressions),
          label: 'Impressions',
        ),
        const SizedBox(width: 6),
        _StatCell(
          value: _formatCount(campaign.clicks),
          label: 'Clicks',
        ),
        const SizedBox(width: 6),
        _StatCell(
          value: '${campaign.ctr.toStringAsFixed(2)}%',
          label: 'CTR ⓘ',
        ),
      ],
    );
  }

  Widget _buildMeta() {
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined,
            color: AppColors.textMuted, size: 12),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Start date',
                style: TextStyle(color: AppColors.textMuted, fontSize: 9)),
            Text(campaign.startDate,
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(width: 16),
        const Icon(Icons.people_outline, color: AppColors.textMuted, size: 12),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Audience',
                style: TextStyle(color: AppColors.textMuted, fontSize: 9)),
            Text(campaign.audience,
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(0)}K';
    return n.toString();
  }
}

class _StatusBadge extends StatelessWidget {
  final CampaignStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isActive = status == CampaignStatus.active;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.badgeActiveBg : AppColors.badgePausedBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5, height: 5,
            decoration: BoxDecoration(
              color: isActive ? AppColors.badgeActive : AppColors.badgePaused,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            isActive ? 'Active' : 'Paused',
            style: TextStyle(
              color: isActive ? AppColors.badgeActive : AppColors.badgePaused,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.statBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 9)),
          ],
        ),
      ),
    );
  }
}