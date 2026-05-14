// import 'package:flutter/material.dart';
// import 'package:media_alacart_test/app/widgets/app_bar.dart';
// import 'package:media_alacart_test/core/theme/app_colors.dart';

// class AnomalyAlertsPage extends StatelessWidget {
//   const AnomalyAlertsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final anomalies = [
//       AnomalyModel(
//         type: 'Spend Spike',
//         title: 'Summer Collection Awareness',
//         subtitle: 'Campaign',
//         description: 'Spend is 72% higher than usual',
//         time: '2m ago',
//         accentColor: const Color(0xFFEF5350),
//         icon: Icons.trending_up,
//         metrics: [
//           MetricModel(
//             label: 'Spend',
//             value: '5,600 SAR',
//             icon: Icons.arrow_upward,
//             color: const Color(0xFFEF5350),
//           ),
//           MetricModel(
//             label: 'Expected',
//             value: '3,250 SAR',
//             icon: Icons.show_chart,
//             color: const Color(0xFF21D4FD),
//           ),
//           MetricModel(
//             label: 'Change',
//             value: '+72%',
//             icon: Icons.north_east,
//             color: const Color(0xFFEF5350),
//           ),
//         ],
//       ),
//       AnomalyModel(
//         type: 'CTR Drop',
//         title: 'Ramadan Offers Campaign',
//         subtitle: 'Campaign',
//         description: 'Spend is -38% higher than usual',
//         time: '5m ago',
//         accentColor: const Color(0xFFFFB300),
//         icon: Icons.trending_down,
//         metrics: [
//           MetricModel(
//             label: 'Spend',
//             value: '5,400 SAR',
//             icon: Icons.arrow_upward,
//             color: const Color(0xFFFFB300),
//           ),
//           MetricModel(
//             label: 'Expected',
//             value: '3,000 SAR',
//             icon: Icons.show_chart,
//             color: const Color(0xFF21D4FD),
//           ),
//           MetricModel(
//             label: 'Change',
//             value: '-38%',
//             icon: Icons.south_east,
//             color: const Color(0xFFFFB300),
//           ),
//         ],
//       ),
//       AnomalyModel(
//         type: 'Spend Spike',
//         title: 'Winter Sale Conversion',
//         subtitle: 'Campaign',
//         description: 'Spend is 55% higher than usual',
//         time: '10m ago',
//         accentColor: const Color(0xFFEF5350),
//         icon: Icons.trending_up,
//         metrics: [
//           MetricModel(
//             label: 'Spend',
//             value: '4,200 SAR',
//             icon: Icons.arrow_upward,
//             color: const Color(0xFFEF5350),
//           ),
//           MetricModel(
//             label: 'Expected',
//             value: '2,700 SAR',
//             icon: Icons.show_chart,
//             color: const Color(0xFF21D4FD),
//           ),
//           MetricModel(
//             label: 'Change',
//             value: '+55%',
//             icon: Icons.north_east,
//             color: const Color(0xFFEF5350),
//           ),
//         ],
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: CustomAppBar(title: "Anomaly Alerts"),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const MonitoringStatusCard(),
//               const SizedBox(height: 20),
//               const SectionHeader(title: 'Recent Anomalies'),
//               const SizedBox(height: 14),
//               ...List.generate(
//                 anomalies.length,
//                 (index) => Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: AnomalyCard(anomaly: anomalies[index]),
//                 ),
//               ),
//               const PushNotificationCard(),
//             ],
//           ),
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

// class MonitoringStatusCard extends StatelessWidget {
//   const MonitoringStatusCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Row(
//         children: [
//           const StatusIcon(),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Monitoring in real-time',
//                   style: TextStyle(
//                     color: AppColors.textPrimary,
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),

//                 const SizedBox(height: 4),

//                 Text(
//                   'Polling Ads API every 30 seconds',
//                   style: TextStyle(color: AppColors.textMuted, fontSize: 11),
//                 ),
//               ],
//             ),
//           ),

//           const LiveIndicator(),
//         ],
//       ),
//     );
//   }
// }

// class StatusIcon extends StatelessWidget {
//   const StatusIcon({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 42,
//       width: 42,
//       decoration: BoxDecoration(
//         color: const Color(0xFF0D2A33),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: const Icon(Icons.wifi_tethering, color: Color(0xFF21D4FD)),
//     );
//   }
// }

// class LiveIndicator extends StatelessWidget {
//   const LiveIndicator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           height: 7,
//           width: 7,
//           decoration: const BoxDecoration(
//             color: Color(0xFF00D26A),
//             shape: BoxShape.circle,
//           ),
//         ),

//         const SizedBox(width: 6),

//         const Text(
//           'Live',
//           style: TextStyle(
//             color: Color(0xFF00D26A),
//             fontWeight: FontWeight.w600,
//             fontSize: 11,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;

//   const SectionHeader({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         title,
//         style: const TextStyle(
//           color: AppColors.textPrimary,
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }
// }

// class AnomalyCard extends StatelessWidget {
//   final AnomalyModel anomaly;

//   const AnomalyCard({super.key, required this.anomaly});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               AlertBadge(
//                 color: anomaly.accentColor,
//                 icon: anomaly.icon,
//                 label: anomaly.type,
//               ),

//               const Spacer(),

//               Text(
//                 anomaly.time,
//                 style: TextStyle(color: AppColors.textMuted, fontSize: 11),
//               ),
//             ],
//           ),

//           const SizedBox(height: 14),

//           Text(
//             anomaly.title,
//             style: const TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//               fontSize: 14,
//             ),
//           ),

//           const SizedBox(height: 4),

//           Text(
//             anomaly.subtitle,
//             style: TextStyle(color: AppColors.textMuted, fontSize: 11),
//           ),

//           const SizedBox(height: 14),

//           Text(
//             anomaly.description,
//             style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
//           ),

//           const SizedBox(height: 16),

//           Row(
//             children: anomaly.metrics
//                 .map(
//                   (metric) => Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: MetricTile(metric: metric),
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AlertBadge extends StatelessWidget {
//   final Color color;
//   final IconData icon;
//   final String label;

//   const AlertBadge({
//     super.key,
//     required this.color,
//     required this.icon,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 15, color: color),

//           const SizedBox(width: 6),

//           Text(
//             label,
//             style: TextStyle(
//               color: color,
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MetricTile extends StatelessWidget {
//   final MetricModel metric;

//   const MetricTile({super.key, required this.metric});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.cardBorder),
//       ),
//       child: Column(
//         children: [
//           Icon(metric.icon, color: metric.color, size: 16),

//           const SizedBox(height: 8),

//           Text(
//             metric.value,
//             style: const TextStyle(
//               color: AppColors.textPrimary,
//               fontWeight: FontWeight.w600,
//               fontSize: 13,
//             ),
//           ),

//           const SizedBox(height: 4),

//           Text(
//             metric.label,
//             style: TextStyle(color: AppColors.textMuted, fontSize: 10),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PushNotificationCard extends StatefulWidget {
//   const PushNotificationCard({super.key});

//   @override
//   State<PushNotificationCard> createState() => _PushNotificationCardState();
// }

// class _PushNotificationCardState extends State<PushNotificationCard> {
//   bool enabled = true;

//   @override
//   Widget build(BuildContext context) {
//     return DashboardCard(
//       child: Row(
//         children: [
//           Container(
//             height: 42,
//             width: 42,
//             decoration: BoxDecoration(
//               color: const Color(0xFF0D2A33),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.notifications_active_outlined,
//               color: Color(0xFF21D4FD),
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Enable Push Notifications',
//                   style: TextStyle(
//                     color: AppColors.textPrimary,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),

//                 const SizedBox(height: 4),

//                 Text(
//                   'Get notified instantly when a new anomaly is detected.',
//                   style: TextStyle(color: AppColors.textMuted, fontSize: 11),
//                 ),
//               ],
//             ),
//           ),

//           Switch(
//             value: enabled,
//             activeColor: AppColors.textPrimary,
//             activeTrackColor: const Color(0xFF21D4FD),
//             inactiveThumbColor: AppColors.textPrimary,
//             inactiveTrackColor: Colors.white24,
//             onChanged: (value) {
//               setState(() {
//                 enabled = value;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AnomalyModel {
//   final String type;
//   final String title;
//   final String subtitle;
//   final String description;
//   final String time;
//   final Color accentColor;
//   final IconData icon;
//   final List<MetricModel> metrics;

//   AnomalyModel({
//     required this.type,
//     required this.title,
//     required this.subtitle,
//     required this.description,
//     required this.time,
//     required this.accentColor,
//     required this.icon,
//     required this.metrics,
//   });
// }

// class MetricModel {
//   final String label;
//   final String value;
//   final IconData icon;
//   final Color color;

//   MetricModel({
//     required this.label,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });
// }
