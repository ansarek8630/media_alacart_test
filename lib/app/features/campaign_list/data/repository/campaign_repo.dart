import 'package:dio/dio.dart';

import '../models/campaign_list_model.dart';

class CampaignRepository {
  final Dio _dio;

  CampaignRepository(this._dio);

  Future<List<Campaign>> fetchCampaigns() async {
    try {      
      final response = await _dio.get('/campaigns');

      if (response.statusCode == 200) {
        return campaignListFromJson(response.toString()).campaigns;
      } else {
        throw Exception('Failed to load campaigns');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  
}