import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/forcast_model.dart';
import 'package:media_alacart_test/core/theme/app_colors.dart';


class PredictiveChart extends StatelessWidget {
  final ForecastData data;

  const PredictiveChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // 1. Historical Line (Solid)
            LineChartBarData(
              spots: data.historical.map((d) => FlSpot(d.dayOffset, d.value)).toList(),
              isCurved: true,
              color: AppColors.primary,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
            
            // 2. Forecast Line (Dashed)
            LineChartBarData(
              spots: data.forecast.map((d) => FlSpot(d.dayOffset, d.value)).toList(),
              isCurved: true,
              color: AppColors.primary,
              barWidth: 2,
              dashArray: [5, 5], // Creates the dashed effect
              dotData: FlDotData(show: false),
            ),

            // 3. Confidence Upper Bound (Invisible line)
            LineChartBarData(
              spots: data.confidenceUpper.map((d) => FlSpot(d.dayOffset, d.value)).toList(),
              show: false, // Hidden, used only for bounding
            ),

            // 4. Confidence Lower Bound (Invisible line)
            LineChartBarData(
              spots: data.confidenceLower.map((d) => FlSpot(d.dayOffset, d.value)).toList(),
              show: false, // Hidden, used only for bounding
            ),
          ],
          
          // Fill the space between Upper (index 2) and Lower (index 3) bounds
          betweenBarsData: [
            BetweenBarsData(
              fromIndex: 2, 
              toIndex: 3,
              color: AppColors.primary.withOpacity(0.15),
            )
          ],
        ),
      ),
    );
  }
}