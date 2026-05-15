import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/campaign_detail_model.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/models/forecast_model.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/campaign_detail_repo.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/forecast_repo.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_event.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_state.dart';

class CampaignDetailBloc
    extends Bloc<CampaignDetailEvent, CampaignDetailState> {
  final CampaignDetailRepository repository;
  final ForecastRepository forecastRepo;

  CampaignDetailBloc({required this.repository, required this.forecastRepo})
    : super(CampaignDetailLoading()) {
    on<LoadCampaignDetail>((event, emit) async {
      emit(CampaignDetailLoading()); // Explicit Loading State

      try {
        // Run both API calls concurrently for better performance
        final results = await Future.wait([
          repository.fetchCampaignDetails(event.campaignId),
          forecastRepo.fetchCampaignForecast(event.campaignId),
        ]);

        final campaign = results[0] as CampaignDetailModel;
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
