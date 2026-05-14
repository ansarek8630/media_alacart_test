class CampaignDetailModel {
  final String id;
  final String name;
  final String status;
  final String objective;
  final String channel;
  final double budget;
  final double spend;
  final int impressions;
  final int clicks;
  final double ctr;
  final String currency;

  CampaignDetailModel({
    required this.id,
    required this.name,
    required this.status,
    required this.objective,
    required this.channel,
    required this.budget,
    required this.spend,
    required this.impressions,
    required this.clicks,
    required this.ctr,
    required this.currency,
  });

  factory CampaignDetailModel.fromJson(Map<String, dynamic> json) {
    final data = json['campaign'];
    return CampaignDetailModel(
      id: data['id'],
      name: data['name'],
      status: data['status'],
      objective: data['objective'],
      channel: data['channel'],
      budget: (data['budget'] as num).toDouble(),
      spend: (data['spend'] as num).toDouble(),
      impressions: data['impressions'],
      clicks: data['clicks'],
      ctr: (data['ctr'] as num).toDouble(),
      currency: data['currency'],
    );
  }
}