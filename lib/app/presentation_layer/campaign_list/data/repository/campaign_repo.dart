import 'package:dio/dio.dart';

import '../models/campaign_list_model.dart';

class CampaignRepository {
  final Dio _dio;

  CampaignRepository(this._dio);

  Future<List<Campaign>> fetchCampaigns() async {
    try {
      // Simulating network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // In a real app, you would use:
      // final response = await _dio.get('https://api.yourdomain.com/v1/campaigns');
      
      // Mocking the Dio response using your provided JSON
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/campaigns'),
        statusCode: 200,
        data: _getDummyJson(),
      );

      if (mockResponse.statusCode == 200) {
        final List<dynamic> data = mockResponse.data!['campaigns'];
        return data.map((json) => Campaign.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load campaigns');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Map<String, dynamic> _getDummyJson() {
    return {
      "campaigns": [
        {
            "id": "camp_001", "name": "Ramadan Mega Sale", "status": "Active",
            "objective": "Conversion", "channel": "Social", "budget": 50000,
            "spend": 34200, "impressions": 1840000, "clicks": 73600,
            "start_date": "2025-03-01", "end_date": "2025-04-30", "currency": "SAR",
            "thumbnail": "https://picsum.photos/seed/camp1/200/120",
            "ctr": 0.04, "budget_utilization": 68.4
        },
        {
            "id": "camp_002", "name": "National Day Electronics", "status": "Active",
            "objective": "Awareness", "channel": "Search", "budget": 80000,
            "spend": 71500, "impressions": 3200000, "clicks": 96000,
            "start_date": "2025-02-15", "end_date": "2025-05-15", "currency": "SAR",
            "thumbnail": "https://picsum.photos/seed/camp2/200/120",
            "ctr": 0.03, "budget_utilization": 89.4
        },
        {
            "id": "camp_003", "name": "Spring Fashion Drop", "status": "Paused",
            "objective": "Conversion", "channel": "Display", "budget": 25000,
            "spend": 12400, "impressions": 620000, "clicks": 18600,
            "start_date": "2025-03-10", "end_date": "2025-04-20", "currency": "SAR",
            "thumbnail": "https://picsum.photos/seed/camp3/200/120",
            "ctr": 0.03, "budget_utilization": 49.6
        }
      ],
      "total": 3
    };
  }
}