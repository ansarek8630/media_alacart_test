class SummaryModel {
  final String range;
  final double totalSpend;
  final List<ChannelData> byChannel;
  final List<TopCampaign> topCampaigns;

  SummaryModel({
    required this.range,
    required this.totalSpend,
    required this.byChannel,
    required this.topCampaigns,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      range: json['range'],
      totalSpend: (json['summary']['total_spend'] as num).toDouble(),
      byChannel: (json['summary']['by_channel'] as List)
          .map((e) => ChannelData.fromJson(e))
          .toList(),
      topCampaigns: (json['summary']['top_campaigns'] as List)
          .map((e) => TopCampaign.fromJson(e))
          .toList(),
    );
  }
}

class ChannelData {
  final String channel;
  final double spend;

  ChannelData({required this.channel, required this.spend});
  factory ChannelData.fromJson(Map<String, dynamic> json) => 
      ChannelData(channel: json['channel'], spend: (json['spend'] as num).toDouble());
}

class TopCampaign {
  final String name;
  final double ctr;

  TopCampaign({required this.name, required this.ctr});
  factory TopCampaign.fromJson(Map<String, dynamic> json) => 
      TopCampaign(name: json['name'], ctr: (json['ctr'] as num).toDouble());
}