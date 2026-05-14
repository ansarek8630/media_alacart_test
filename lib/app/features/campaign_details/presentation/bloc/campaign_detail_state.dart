import 'package:media_alacart_test/app/features/campaign_details/data/models/campaign_detail_model.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/forcast_model.dart';

abstract class CampaignDetailState {}
class CampaignDetailLoading extends CampaignDetailState {}
class CampaignDetailLoaded extends CampaignDetailState {
  final CampaignDetailModel campaign;
  final ForecastData forecast;
  CampaignDetailLoaded(this.campaign, this.forecast);
}
class CampaignDetailEmpty extends CampaignDetailState {}
class CampaignDetailError extends CampaignDetailState {
  final String message;
  CampaignDetailError(this.message);
}
