import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/presentation_layer/campaign_list/presentation/bloc/campaign_event.dart';
import 'package:media_alacart_test/app/presentation_layer/campaign_list/presentation/bloc/campaign_state.dart';

import '../../data/models/campaign_list_model.dart';
import '../../data/repository/campaign_repo.dart';


class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository repository;

  CampaignBloc(this.repository) : super(CampaignInitial()) {
    on<FetchCampaigns>((event, emit) async {
      emit(CampaignLoading());
      try {
        final campaigns = await repository.fetchCampaigns();
        emit(CampaignLoaded(allCampaigns: campaigns, filteredCampaigns: campaigns, currentFilter: 'All'));
      } catch (e) {
        emit(CampaignError(e.toString()));
      }
    });

    on<FilterCampaigns>((event, emit) {
      if (state is CampaignLoaded) {
        final currentState = state as CampaignLoaded;
        List<Campaign> filtered;
        
        if (event.filterStatus == 'All') {
          filtered = currentState.allCampaigns;
        } else {
          filtered = currentState.allCampaigns.where((c) => c.status == event.filterStatus).toList();
        }
        
        emit(CampaignLoaded(
          allCampaigns: currentState.allCampaigns,
          filteredCampaigns: filtered,
          currentFilter: event.filterStatus,
        ));
      }
    });
  }
}