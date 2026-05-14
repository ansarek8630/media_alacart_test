// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/features/campaign_list/presentation/bloc/campaign_event.dart';
import 'package:media_alacart_test/app/features/campaign_list/presentation/bloc/campaign_state.dart';
import 'package:media_alacart_test/app/widgets/app_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../bloc/campaign_bloc.dart';
import '../components/campaign_card.dart';

class CampaignListPage extends StatefulWidget {
  const CampaignListPage({super.key});

  @override
  _CampaignListPageState createState() => _CampaignListPageState();
}

class _CampaignListPageState extends State<CampaignListPage> {
  @override
  void initState() {
    super.initState();
    context.read<CampaignBloc>().add(FetchCampaigns());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Campaigns'),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          Expanded(
            child: BlocBuilder<CampaignBloc, CampaignState>(
              builder: (context, state) {
                if (state is CampaignLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                } else if (state is CampaignError) {
                  return Center(
                    child: Text(state.message, style: AppTextStyles.body),
                  );
                } else if (state is CampaignLoaded) {
                  return RefreshIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    onRefresh: () async {
                      context.read<CampaignBloc>().add(FetchCampaigns());
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.filteredCampaigns.length,
                      itemBuilder: (context, index) {
                        final campaign = state.filteredCampaigns[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: campaign.id,
                            );
                          },

                          child: CampaignCard(
                            campaign: state.filteredCampaigns[index],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                style: AppTextStyles.body,
                decoration: InputDecoration(
                  hintText: 'Search Campaigns...',
                  hintStyle: AppTextStyles.body,
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(Icons.tune, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (context, state) {
        String activeFilter = 'All';
        if (state is CampaignLoaded) {
          activeFilter = state.currentFilter;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(bottom: 16),
          child: Row(
            children: ['All', 'Active', 'Paused'].map((filter) {
              final isSelected = activeFilter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    context.read<CampaignBloc>().add(FilterCampaigns(filter));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.surfaceLight
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
