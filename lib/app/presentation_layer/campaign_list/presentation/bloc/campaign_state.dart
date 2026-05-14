import '../../data/models/campaign_list_model.dart';

abstract class CampaignState {}
class CampaignInitial extends CampaignState {}
class CampaignLoading extends CampaignState {}
class CampaignLoaded extends CampaignState {
  final List<Campaign> allCampaigns;
  final List<Campaign> filteredCampaigns;
  final String currentFilter;

  CampaignLoaded({required this.allCampaigns, required this.filteredCampaigns, required this.currentFilter});
}
class CampaignError extends CampaignState {
  final String message;
  CampaignError(this.message);
}