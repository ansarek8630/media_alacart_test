import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
import '../../repository/campaign_model.dart';
import '../../repository/campaign_status.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/campaign_card.dart';
import '../../widgets/filter_chips.dart';
import '../../widgets/search_bar.dart';


class CampaignListPage extends StatefulWidget {
  const CampaignListPage({super.key});

  @override
  State<CampaignListPage> createState() => _CampaignListPageState();
}

class _CampaignListPageState extends State<CampaignListPage> {
  int _navIndex = 0;
  String _selectedFilter = 'All';

  final _campaigns = const [
    CampaignModel(
      name: 'Summer Collection Awareness Campaign',
      type: 'Awareness',
      status: CampaignStatus.active,
      totalSpend: 3200,
      budget: 5000,
      impressions: 129000,
      clicks: 3400,
      ctr: 2.83,
      startDate: '12 May 2025',
      audience: 'Women 18–35, KSA',
    ),
    CampaignModel(
      name: 'New Product Launch',
      type: 'Awareness',
      status: CampaignStatus.paused,
      totalSpend: 2100,
      budget: 6000,
      impressions: 95000,
      clicks: 2700,
      ctr: 2.84,
      startDate: '01 Apr 2026',
      audience: 'Tech Enthusiasts, KSA',
    ),
  ];

  List<CampaignModel> get _filtered {
    if (_selectedFilter == 'All') return _campaigns;
    if (_selectedFilter == 'Active') {
      return _campaigns
          .where((c) => c.status == CampaignStatus.active)
          .toList();
    }
    return _campaigns
        .where((c) => c.status == CampaignStatus.paused)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Campaign List'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        children: [
          CampaignSearchBar(),
          const SizedBox(height: 12),
          FilterChips(
            options: const ['All', 'Active', 'Paused'],
            selected: _selectedFilter,
            onSelect: (v) => setState(() => _selectedFilter = v),
          ),
          const SizedBox(height: 10),
          // Column headers
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Impressions',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                Text('Clicks',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                Text('CTR ⓘ',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ..._filtered.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CampaignCard(campaign: c),
              )),
        ],
      ),
    );
  }


}