class Campaign {
  final String id;
  final String name;
  final String status;
  final String objective;
  final String channel;
  final double budget;
  final double spend;
  final int impressions;
  final int clicks;
  final String startDate;
  final String currency;

  Campaign({
    required this.id,
    required this.name,
    required this.status,
    required this.objective,
    required this.channel,
    required this.budget,
    required this.spend,
    required this.impressions,
    required this.clicks,
    required this.startDate,
    required this.currency,
  });

  // Client-side CTR Calculation as requested
  double get clientCalculatedCtr {
    if (impressions == 0) return 0.0;
    return (clicks / impressions) * 100;
  }

  double get budgetUtilizationPercentage {
    if (budget == 0) return 0.0;
    return spend / budget;
  }

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      objective: json['objective'],
      channel: json['channel'],
      budget: (json['budget'] as num).toDouble(),
      spend: (json['spend'] as num).toDouble(),
      impressions: json['impressions'],
      clicks: json['clicks'],
      startDate: json['start_date'],
      currency: json['currency'],
    );
  }
}