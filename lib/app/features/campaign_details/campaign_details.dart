import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/campaign_detail_model.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/forcast_model.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_bloc.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_event.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_state.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/components/predictive_chart.dart';
import '../../../../core/theme/app_colors.dart';



class CampaignDetailScreen extends StatelessWidget {
  const CampaignDetailScreen({super.key});

  /// Formats large numbers for KPI display (e.g., 940000 -> 940.0K)
  String _formatNumber(int number) {
    if (number >= 1000000) return '${(number / 1000000).toStringAsFixed(1)}M';
    if (number >= 1000) return '${(number / 1000).toStringAsFixed(1)}K';
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today, size: 20), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
        builder: (context, state) {
          if (state is CampaignDetailLoading) return _buildLoadingState();
          if (state is CampaignDetailEmpty) return _buildEmptyState();
          if (state is CampaignDetailError) return _buildErrorState(context, state.message);
          
          if (state is CampaignDetailLoaded) {
            // Pass the entire state object containing campaign and forecast
            return _buildLoadedState(state);
          }
          
          return const SizedBox();
        },
      ),
    );
  }

  // --- Main Content UI ---

  Widget _buildLoadedState(CampaignDetailLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(state.campaign),
          const SizedBox(height: 24),
          _buildKPIGrid(state.campaign),
          const SizedBox(height: 16),
          PredictiveChart(data: state.forecast),
          const SizedBox(height: 16),
          _buildDynamicRecommendation(state.forecast),
        ],
      ),
    );
  }

  Widget _buildHeader(CampaignDetailModel campaign) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          campaign.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildPill(campaign.status, AppColors.success),
            const SizedBox(width: 8),
            _buildPill(campaign.objective, AppColors.info, isStatus: false),
          ],
        ),
      ],
    );
  }

  Widget _buildPill(String text, Color color, {bool isStatus = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isStatus) ...[
            CircleAvatar(radius: 3, backgroundColor: color),
            const SizedBox(width: 6),
          ],
          Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildKPIGrid(CampaignDetailModel campaign) {
    return Row(
      children: [
        _kpiItem(Icons.visibility, _formatNumber(campaign.impressions), "Impressions"),
        _kpiItem(Icons.ads_click, _formatNumber(campaign.clicks), "Clicks"),
        _kpiItem(Icons.trending_up, "${(campaign.ctr * 100).toStringAsFixed(2)}%", "CTR"),
        _kpiItem(Icons.account_balance_wallet, "${campaign.spend.toInt()} SAR", "Total spend"),
      ],
    );
  }

  Widget _kpiItem(IconData icon, String val, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  // --- Predictive Chart Section ---


  LineChartData _getChartData(ForecastData data) {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 35)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        // Historical (Solid)
        LineChartBarData(
          spots: data.historical.map((e) => FlSpot(e.dayOffset, e.value)).toList(),
          isCurved: true,
          color: AppColors.primary,
          barWidth: 2,
          dotData: FlDotData(show: false),
        ),
        // Forecast (Dashed)
        LineChartBarData(
          spots: data.forecast.map((e) => FlSpot(e.dayOffset, e.value)).toList(),
          isCurved: true,
          color: AppColors.primary,
          barWidth: 2,
          dashArray: [5, 5],
          dotData: FlDotData(show: false),
        ),
      ],
    );
  }

  // --- Recommendation Card ---

  Widget _buildDynamicRecommendation(ForecastData forecast) {
    final isPositive = forecast.predictedChangePercentage > 0;
    final color = isPositive ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(isPositive ? Icons.trending_up : Icons.trending_down, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Budget Recommendation", style: TextStyle(color: color, fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  "CTR is predicted to ${isPositive ? 'increase' : 'decrease'} by ${forecast.predictedChangePercentage.abs().toStringAsFixed(1)}%",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Consider increasing budget to maximize results",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLoadingState() => const Center(child: CircularProgressIndicator(color: AppColors.primary));

  Widget _buildEmptyState() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory_2_outlined, size: 48, color: AppColors.surfaceLight),
            const SizedBox(height: 16),
            const Text("No data available", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Try adjusting your date filters.", style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      );

  Widget _buildErrorState(BuildContext context, String msg) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 48),
            const SizedBox(height: 16),
            Text(msg, textAlign: TextAlign.center),
            TextButton(
              onPressed: () => context.read<CampaignDetailBloc>().add(LoadCampaignDetail("camp_004")),
              child: const Text("Retry", style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      );
}