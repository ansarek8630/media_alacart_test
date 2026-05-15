import 'dart:convert';

CampaignList campaignListFromJson(String str) =>
    CampaignList.fromJson(json.decode(str));

String campaignListToJson(CampaignList data) =>
    json.encode(data.toJson());

class CampaignList {
  final List<Campaign> campaigns;
  final int total;

  CampaignList({
    required this.campaigns,
    required this.total,
  });

  factory CampaignList.fromJson(
    Map<String, dynamic> json,
  ) {
    return CampaignList(
      campaigns: json['campaigns'] == null
          ? []
          : List<Campaign>.from(
              (json['campaigns'] as List)
                  .map(
                    (x) => Campaign.fromJson(x),
                  ),
            ),
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campaigns':
          campaigns.map((x) => x.toJson()).toList(),
      'total': total,
    };
  }
}

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

  final DateTime? startDate;
  final DateTime? endDate;

  final String currency;
  final String thumbnail;

  /// API values
  final double ctr;
  final double budgetUtilization;

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
    required this.endDate,
    required this.currency,
    required this.thumbnail,
    required this.ctr,
    required this.budgetUtilization,
  });

  // =========================================================
  // CLIENT SIDE CALCULATIONS
  // =========================================================

  /// CTR = (Clicks / Impressions) * 100
  double get clientCalculatedCtr {
    if (impressions == 0) return 0.0;

    return (clicks / impressions) * 100;
  }

  /// Budget Utilization = (Spend / Budget) * 100
  double get budgetUtilizationPercentage {
    if (budget == 0) return 0.0;

    return (spend / budget) * 100;
  }

  /// Remaining Budget
  double get remainingBudget {
    return budget - spend;
  }

  /// CPC = Cost Per Click
  double get costPerClick {
    if (clicks == 0) return 0.0;

    return spend / clicks;
  }

  /// CPM = Cost Per 1000 Impressions
  double get costPerThousandImpressions {
    if (impressions == 0) return 0.0;

    return (spend / impressions) * 1000;
  }

  /// Campaign duration in days
  int get campaignDurationDays {
    if (startDate == null || endDate == null) {
      return 0;
    }

    return endDate!
        .difference(startDate!)
        .inDays;
  }

  /// Remaining campaign days
  int get remainingCampaignDays {
    if (endDate == null) return 0;

    return endDate!
        .difference(DateTime.now())
        .inDays;
  }

  /// Is campaign active
  bool get isActive {
    return status.toLowerCase() == 'active';
  }

  /// Progress value for linear progress indicator
  double get progressValue {
    if (budget == 0) return 0.0;

    final progress = spend / budget;

    return progress.clamp(0.0, 1.0);
  }

  // =========================================================
  // JSON SERIALIZATION
  // =========================================================

  factory Campaign.fromJson(
    Map<String, dynamic> json,
  ) {
    return Campaign(
      id: json['id'] ?? '',

      name: json['name'] ?? '',

      status: json['status'] ?? '',

      objective: json['objective'] ?? '',

      channel: json['channel'] ?? '',

      budget:
          (json['budget'] as num?)
                  ?.toDouble() ??
              0.0,

      spend:
          (json['spend'] as num?)
                  ?.toDouble() ??
              0.0,

      impressions:
          json['impressions'] ?? 0,

      clicks: json['clicks'] ?? 0,

      startDate:
          json['start_date'] != null
              ? DateTime.tryParse(
                  json['start_date'],
                )
              : null,

      endDate: json['end_date'] != null
          ? DateTime.tryParse(
              json['end_date'],
            )
          : null,

      currency: json['currency'] ?? '',

      thumbnail: json['thumbnail'] ?? '',

      ctr:
          (json['ctr'] as num?)
                  ?.toDouble() ??
              0.0,

      budgetUtilization:
          (json['budget_utilization']
                      as num?)
                  ?.toDouble() ??
              0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'name': name,

      'status': status,

      'objective': objective,

      'channel': channel,

      'budget': budget,

      'spend': spend,

      'impressions': impressions,

      'clicks': clicks,

      'start_date':
          startDate?.toIso8601String(),

      'end_date':
          endDate?.toIso8601String(),

      'currency': currency,

      'thumbnail': thumbnail,

      'ctr': ctr,

      'budget_utilization':
          budgetUtilization,
    };
  }
}