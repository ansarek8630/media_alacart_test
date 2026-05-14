abstract class CampaignDetailEvent {}
class LoadCampaignDetail extends CampaignDetailEvent {
  final String campaignId;
  LoadCampaignDetail(this.campaignId);
}