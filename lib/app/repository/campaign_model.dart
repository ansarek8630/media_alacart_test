import 'campaign_status.dart';

class CampaignModel {
  final String name;
  final String type;
  final CampaignStatus status;
  final double totalSpend;
  final double budget;
  final int impressions;
  final int clicks;
  final double ctr;
  final String startDate;
  final String audience;

  const CampaignModel({
    required this.name,
    required this.type,
    required this.status,
    required this.totalSpend,
    required this.budget,
    required this.impressions,
    required this.clicks,
    required this.ctr,
    required this.startDate,
    required this.audience,
  });

  double get progress => totalSpend / budget;
}