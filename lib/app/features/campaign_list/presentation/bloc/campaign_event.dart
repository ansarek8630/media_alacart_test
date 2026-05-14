abstract class CampaignEvent {}
class FetchCampaigns extends CampaignEvent {}
class FilterCampaigns extends CampaignEvent {
  final String filterStatus; // 'All', 'Active', 'Paused'
  FilterCampaigns(this.filterStatus);
}