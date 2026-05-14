import 'package:dio/dio.dart';
import '../models/summary_model.dart';

class SummaryRepository {
  final Dio _dio;
  SummaryRepository(this._dio);

  Future<SummaryModel> fetchSummary(String range) async {
    try {
      // Simulate API Call with the provided JSON structure
      await Future.delayed(const Duration(milliseconds: 800));
      
      final mockResponse = {
        "range": range,
        "summary": {
          "total_spend": range == "last_7_days" ? 18400 : 42000,
          "by_channel": [
            {"channel": "Search", "spend": 8900},
            {"channel": "Social", "spend": 6200},
            {"channel": "Display", "spend": 3300}
          ],
          "top_campaigns": [
            {"name": "Ramadan Mega Sale", "ctr": 0.054},
            {"name": "Back to School Supplies", "ctr": 0.048},
            {"name": "Premium Members Upsell", "ctr": 0.046}
          ]
        }
      };

      return SummaryModel.fromJson(mockResponse);
    } catch (e) {
      throw Exception("Failed to fetch summary data");
    }
  }
}