// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:media_alacart_test/app/widgets/app_bar.dart';
// import 'package:media_alacart_test/core/theme/app_colors.dart';

// class CampaignDetailsPage extends StatelessWidget {
//   const CampaignDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: CustomAppBar(title: "Campaign Details"),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: const [
//               MetricsOverviewSection(),
//               SizedBox(height: 16),
//               CTRForecastChartCard(),
//               SizedBox(height: 16),
//               RecommendationCard(),
//               SizedBox(height: 20),
//               StatesSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StatusChip extends StatelessWidget {
//   final String label;
//   final Color color;

//   const StatusChip({super.key, required this.label, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: color,
//           fontSize: 10,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final Widget child;
//   final EdgeInsetsGeometry? padding;

//   const DashboardCard({super.key, required this.child, this.padding});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: padding ?? const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF111522),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.04)),
//       ),
//       child: child,
//     );
//   }
// }

// class MetricsOverviewSection extends StatelessWidget {
//   const MetricsOverviewSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final metrics = [
//       CampaignMetric(
//         title: 'Impressions',
//         value: '150K',
//         icon: Icons.remove_red_eye_outlined,
//       ),
//       CampaignMetric(
//         title: 'Clicks',
//         value: '6.2K',
//         icon: Icons.ads_click_outlined,
//       ),
//       CampaignMetric(title: 'CTR', value: '2.48%', icon: Icons.show_chart),
//       CampaignMetric(
//         title: 'Total spend',
//         value: '7,800 SAR',
//         icon: Icons.account_balance_wallet_outlined,
//       ),
//     ];

//     return Row(
//       children: List.generate(
//         metrics.length,
//         (index) => Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(
//               right: index != metrics.length - 1 ? 8 : 0,
//             ),
//             child: MetricOverviewCard(metric: metrics[index]),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MetricOverviewCard extends StatelessWidget {
//   final CampaignMetric metric;

//   const MetricOverviewCard({super.key, required this.metric});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(metric.icon, color: const Color(0xFF21D4FD), size: 18),
//           const SizedBox(height: 10),
//           Text(
//             metric.value,
//             style: const TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             metric.title,
//             style: TextStyle(color: AppColors.textMuted, fontSize: 10),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CTRForecastChartCard extends StatelessWidget {
//   const CTRForecastChartCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Expanded(
//                 child: Text(
//                   'CTR Performance & Forecast',
//                   style: TextStyle(
//                     color: AppColors.textPrimary,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),

//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: AppColors.cardBorder),
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       '30 Days',
//                       style: TextStyle(
//                         color: AppColors.textMuted,
//                         fontSize: 10,
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Icon(
//                       Icons.keyboard_arrow_down,
//                       color: AppColors.textMuted,
//                       size: 16,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           Row(
//             children: [
//               const ChartLegend(
//                 label: 'Historical CTR',
//                 color: Color(0xFF21D4FD),
//               ),

//               const SizedBox(width: 18),

//               ChartLegend(
//                 label: 'Forecast CTR',
//                 color: const Color(0xFF00D26A).withOpacity(0.8),
//                 dashed: true,
//               ),
//             ],
//           ),

//           const SizedBox(height: 18),

//           SizedBox(
//             height: 220,
//             child: LineChart(
//               LineChartData(
//                 minY: 0,
//                 maxY: 6,
//                 gridData: FlGridData(
//                   drawVerticalLine: true,
//                   horizontalInterval: 1,
//                   verticalInterval: 1,
//                   getDrawingHorizontalLine: (value) {
//                     return FlLine(color: AppColors.cardBorder, strokeWidth: 1);
//                   },
//                   getDrawingVerticalLine: (value) {
//                     return FlLine(color: AppColors.cardBorder, strokeWidth: 1);
//                   },
//                 ),
//                 borderData: FlBorderData(show: false),
//                 titlesData: FlTitlesData(
//                   topTitles: const AxisTitles(),
//                   rightTitles: const AxisTitles(),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       interval: 2,
//                       reservedSize: 32,
//                       getTitlesWidget: (value, meta) {
//                         return Text(
//                           '${value.toInt()}%',
//                           style: TextStyle(
//                             color: AppColors.textMuted,
//                             fontSize: 10,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 26,
//                       interval: 1,
//                       getTitlesWidget: (value, meta) {
//                         final titles = {
//                           0: '02 Jun',
//                           2: '09 Jun',
//                           5: '23 Jun',
//                           8: '29 Jun',
//                           11: '03 July',
//                           14: '10 July',
//                         };

//                         return Padding(
//                           padding: const EdgeInsets.only(top: 10),
//                           child: Text(
//                             titles[value.toInt()] ?? '',
//                             style: TextStyle(
//                               color: AppColors.textMuted,
//                               fontSize: 10,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 extraLinesData: ExtraLinesData(
//                   verticalLines: [
//                     VerticalLine(
//                       x: 7,
//                       color: AppColors.textMuted,
//                       strokeWidth: 1,
//                       dashArray: [5, 5],
//                     ),
//                   ],
//                 ),
//                 lineBarsData: [
//                   LineChartBarData(
//                     isCurved: true,
//                     color: const Color(0xFF21D4FD),
//                     barWidth: 3,
//                     belowBarData: BarAreaData(
//                       show: true,
//                       color: const Color(0xFF21D4FD).withOpacity(0.12),
//                     ),
//                     dotData: const FlDotData(show: false),
//                     spots: const [
//                       FlSpot(0, 2.5),
//                       FlSpot(1, 3.2),
//                       FlSpot(2, 2.8),
//                       FlSpot(3, 4.1),
//                       FlSpot(4, 3.0),
//                       FlSpot(5, 3.7),
//                       FlSpot(6, 3.2),
//                       FlSpot(7, 4.0),
//                     ],
//                   ),

//                   LineChartBarData(
//                     isCurved: true,
//                     color: const Color(0xFF00D26A),
//                     barWidth: 3,
//                     dashArray: [6, 6],
//                     belowBarData: BarAreaData(
//                       show: true,
//                       color: const Color(0xFF00D26A).withOpacity(0.08),
//                     ),
//                     dotData: const FlDotData(show: false),
//                     spots: const [
//                       FlSpot(7, 4.0),
//                       FlSpot(8, 3.8),
//                       FlSpot(9, 4.1),
//                       FlSpot(10, 4.0),
//                       FlSpot(11, 3.5),
//                       FlSpot(12, 3.7),
//                       FlSpot(13, 3.2),
//                       FlSpot(14, 3.6),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChartLegend extends StatelessWidget {
//   final String label;
//   final Color color;
//   final bool dashed;

//   const ChartLegend({
//     super.key,
//     required this.label,
//     required this.color,
//     this.dashed = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 14,
//           height: 2,
//           decoration: BoxDecoration(
//             color: dashed ? Colors.transparent : color,
//             border: dashed ? Border.all(color: color, width: 1) : null,
//           ),
//         ),

//         const SizedBox(width: 6),

//         Text(label, style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
//       ],
//     );
//   }
// }

// class RecommendationCard extends StatelessWidget {
//   const RecommendationCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Row(
//         children: [
//           Container(
//             height: 42,
//             width: 42,
//             decoration: BoxDecoration(
//               color: const Color(0xFF103025),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.trending_up, color: Color(0xFF00D26A)),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Budget Recommendation',
//                   style: TextStyle(
//                     color: Color(0xFF00D26A),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 11,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 const Text(
//                   'CTR is predicted to increase by 12% ↗',
//                   style: TextStyle(
//                     color: AppColors.textPrimary,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   'Consider increasing budget to maximize results',
//                   style: TextStyle(color: AppColors.textMuted, fontSize: 11),
//                 ),
//               ],
//             ),
//           ),

//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//               color: const Color(0xFF103025),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: const Color(0xFF00D26A).withOpacity(0.2),
//               ),
//             ),
//             child: const Text(
//               'View Details',
//               style: TextStyle(
//                 color: Color(0xFF00D26A),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 11,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class StatesSection extends StatelessWidget {
//   const StatesSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             'States',
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//             ),
//           ),
//         ),

//         const SizedBox(height: 14),

//         Row(
//           children: const [
//             Expanded(child: LoadingStateCard()),
//             SizedBox(width: 10),
//             Expanded(child: EmptyStateCard()),
//             SizedBox(width: 10),
//             Expanded(child: ErrorStateCard()),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class LoadingStateCard extends StatelessWidget {
//   const LoadingStateCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Loading',
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(height: 18),

//           Container(
//             height: 8,
//             width: 60,
//             decoration: BoxDecoration(
//               color: AppColors.cardBorder,
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),

//           const SizedBox(height: 12),

//           Container(
//             height: 8,
//             width: 90,
//             decoration: BoxDecoration(
//               color: AppColors.cardBorder,
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),

//           const SizedBox(height: 18),

//           const Center(
//             child: SizedBox(
//               height: 24,
//               width: 24,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: Color(0xFF21D4FD),
//               ),
//             ),
//           ),

//           const SizedBox(height: 18),

//           Container(
//             height: 8,
//             width: 70,
//             decoration: BoxDecoration(
//               color: AppColors.cardBorder,
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EmptyStateCard extends StatelessWidget {
//   const EmptyStateCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Column(
//         children: [
//           Container(
//             height: 42,
//             width: 42,
//             decoration: BoxDecoration(
//               color: AppColors.cardBorder,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               Icons.inventory_2_outlined,
//               color: AppColors.textPrimary,
//             ),
//           ),

//           const SizedBox(height: 16),

//           const Text(
//             'No data available',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             'There is no data to display for this period.',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: AppColors.textMuted, fontSize: 10),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ErrorStateCard extends StatelessWidget {
//   const ErrorStateCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Column(
//         children: [
//           Container(
//             height: 42,
//             width: 42,
//             decoration: BoxDecoration(
//               color: const Color(0xFF341A1D),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(Icons.error_outline, color: Color(0xFFEF5350)),
//           ),

//           const SizedBox(height: 16),

//           const Text(
//             'Failed to load data',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//               fontSize: 12,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             'Something went wrong',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: AppColors.textMuted, fontSize: 10),
//           ),

//           const SizedBox(height: 16),

//           const Text(
//             'Retry',
//             style: TextStyle(
//               color: Color(0xFF21D4FD),
//               fontWeight: FontWeight.w600,
//               fontSize: 11,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CampaignMetric {
//   final String title;
//   final String value;
//   final IconData icon;

//   CampaignMetric({
//     required this.title,
//     required this.value,
//     required this.icon,
//   });
// }
