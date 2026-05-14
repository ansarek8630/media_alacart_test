import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/campaign_detail_model.dart';

class CampaignDetailRepository {
  final Dio _dio;

  CampaignDetailRepository(this._dio);

  Future<CampaignDetailModel> fetchCampaignDetails(String campaignId) async {
    try {
      // Simulating network delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final mockResponse = {
        "campaign": {
          "id": "camp_004",
          "name": "Back to School Supplies",
          "status": "Active",
          "objective": "Conversion",
          "channel": "Search",
          "budget": 35000,
          "spend": 18900,
          "impressions": 940000,
          "clicks": 42300,
          "ctr": 0.045,
          "currency": "SAR",
        },
      };

      return CampaignDetailModel.fromJson(mockResponse);
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to load campaign details");
    }
  }
}
