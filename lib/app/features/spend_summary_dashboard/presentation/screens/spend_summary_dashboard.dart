import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:media_alacart_test/core/theme/app_colors.dart';
import '../bloc/summary_bloc.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "Spend Summary",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.menu),
      ),
      body: BlocBuilder<SummaryBloc, SummaryState>(
        builder: (context, state) {
          if (state is SummaryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SummaryError) return Center(child: Text(state.message));
          if (state is SummaryLoaded) {
            final data = state.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildKPICard(data.totalSpend),
                  const SizedBox(height: 16),
                  _buildChannelChart(data),
                  const SizedBox(height: 16),
                  _buildTopCampaigns(data),
                  const SizedBox(height: 16),
                  _buildDateRangePicker(context, data.range),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildKPICard(double spend) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.trending_up, color: Colors.green),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Spend",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              Text(
                "${spend.toInt()} SAR",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelChart(dynamic data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Spend by channel",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 35,
                    sections: _getSections(data),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(child: _buildLegend(data)),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getSections(dynamic data) {
    return [
      PieChartSectionData(
        color: AppColors.channelSearch,
        value: 40,
        radius: 15,
        title: "",
      ),
      PieChartSectionData(
        color: AppColors.channelSocial,
        value: 35,
        radius: 15,
        title: "",
      ),
      PieChartSectionData(
        color: AppColors.channelDisplay,
        value: 25,
        radius: 15,
        title: "",
      ),
    ];
  }

  Widget _buildLegend(dynamic data) {
    return Column(
      children: [
        _legendItem("Search", "40%", AppColors.channelSearch),
        _legendItem("Social", "35%", AppColors.channelSocial),
        _legendItem("Display", "25%", AppColors.channelDisplay),
      ],
    );
  }

  Widget _legendItem(String label, String val, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            val,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCampaigns(dynamic data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top 3 Campaigns by CTR",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...List.generate(data.topCampaigns.length, (index) {
            final camp = data.topCampaigns[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    "${index + 1}",
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.campaign,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      camp.name,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Text(
                    "${(camp.ctr * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.north_east, color: Colors.green, size: 14),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDateRangePicker(BuildContext context, String currentRange) {
    final ranges = ["last_7_days", "last_14_days", "last_30_days"];
    final labels = ["Last 7 Days", "Last 14 Days", "Last 30 Days"];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Date Range",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(3, (i) {
              bool isSelected = currentRange == ranges[i];
              return Expanded(
                child: GestureDetector(
                  onTap: () =>
                      context.read<SummaryBloc>().add(LoadSummary(ranges[i])),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.background,
                      border: isSelected
                          ? Border.all(color: AppColors.primary)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        labels[i],
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
