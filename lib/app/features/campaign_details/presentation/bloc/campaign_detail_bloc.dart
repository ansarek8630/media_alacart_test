import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/forcast_model.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/campaign_detail_repo.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_event.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_state.dart';

class CampaignDetailBloc
    extends Bloc<CampaignDetailEvent, CampaignDetailState> {
  final CampaignDetailRepository repository;

  CampaignDetailBloc(this.repository, {required forecastRepo, required campaignRepo}) : super(CampaignDetailLoading()) {

    on<LoadCampaignDetail>((event, emit) async {
  emit(CampaignDetailLoading()); // Explicit Loading State
  
  try {
    // Run both API calls concurrently for better performance
    final results = await Future.wait([
      repository.fetchCampaignDetails(event.campaignId),
    ]);

    final campaign = results[0];
    final forecast = results[1] as ForecastData;

    // Explicit Empty State handling
    if (forecast.historical.isEmpty) {
      emit(CampaignDetailEmpty());
    } else {
      emit(CampaignDetailLoaded(campaign, forecast));
    }
  } catch (e) {
    // Explicit Error State
    emit(CampaignDetailError("Failed to load prediction data.")); 
  }
});
  }
  
}
