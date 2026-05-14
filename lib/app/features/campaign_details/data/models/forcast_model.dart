class CtrDataPoint {
  final double dayOffset; // X-axis (0 to 30 for historical, 30 to 37 for forecast)
  final double value;     // Y-axis (CTR percentage)

  CtrDataPoint(this.dayOffset, this.value);
}

class ForecastData {
  final List<CtrDataPoint> historical;
  final List<CtrDataPoint> forecast;
  final List<CtrDataPoint> confidenceUpper;
  final List<CtrDataPoint> confidenceLower;
  final double predictedChangePercentage;

  ForecastData({
    required this.historical,
    required this.forecast,
    required this.confidenceUpper,
    required this.confidenceLower,
    required this.predictedChangePercentage,
  });
}