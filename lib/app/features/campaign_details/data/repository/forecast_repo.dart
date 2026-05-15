import 'package:dio/dio.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/forecast_model.dart';

class ForecastRepository {
  final Dio _dio;
  ForecastRepository(this._dio);

  Future<ForecastData> fetchCampaignForecast(String campaignId) async {
    try {
      // 1. Fetch 30-day historical data from Ads API
      await Future.delayed(const Duration(milliseconds: 600));
      final historicalData = List.generate(
        30,
        (index) => CtrDataPoint(
          index.toDouble(),
          2.0 + (index % 5) * 0.4,
        ), // Mock wave pattern
      );

      // 2. Send to ML Forecast API
      await Future.delayed(const Duration(milliseconds: 600));

      // Mock ML response: 7 days of forecast starting from day 30
      final lastHistoricalValue = historicalData.last.value;
      final forecastData = List.generate(
        7,
        (index) => CtrDataPoint(
          30.0 + index,
          lastHistoricalValue + (index * 0.15),
        ), // Trending up
      );

      final upper = forecastData
          .map((p) => CtrDataPoint(p.dayOffset, p.value + 0.5))
          .toList();
      final lower = forecastData
          .map((p) => CtrDataPoint(p.dayOffset, p.value - 0.5))
          .toList();

      // Calculate recommendation percentage
      final change =
          ((forecastData.last.value - lastHistoricalValue) /
              lastHistoricalValue) *
          100;

      return ForecastData(
        historical: historicalData,
        forecast: forecastData,
        confidenceUpper: upper,
        confidenceLower: lower,
        predictedChangePercentage: change,
      );
    } catch (e) {
      throw Exception("Failed to generate forecast");
    }
  }
}
