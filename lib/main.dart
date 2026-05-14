import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/presentation_layer/campaign_list/presentation/bloc/campaign_event.dart';
import 'package:media_alacart_test/app/presentation_layer/spend_summary_dashboard/data/repository/summary_repo.dart';
import 'package:media_alacart_test/app/presentation_layer/spend_summary_dashboard/presentation/bloc/summary_bloc.dart';

// Import necessary layers
import 'app/presentation_layer/bottom_nav/bottom_nav.dart';
import 'app/presentation_layer/campaign_list/data/repository/campaign_repo.dart';
import 'app/presentation_layer/campaign_list/presentation/bloc/campaign_bloc.dart';


void main() {
  // 1. Initialize Network Client
  final dio = Dio();

  // 2. Initialize Repositories
  final campaignRepository = CampaignRepository(dio);
  final summaryRepository = SummaryRepository(dio);

  runApp(
    MultiBlocProvider(
      providers: [
        // Providing CampaignBloc for the list view
        BlocProvider<CampaignBloc>(
          create: (context) => CampaignBloc(campaignRepository)..add(FetchCampaigns()),
        ),
        // Providing SummaryBloc for the dashboard view
        BlocProvider<SummaryBloc>(
          create: (context) => SummaryBloc(summaryRepository)..add(LoadSummary("last_7_days")),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(), // Matches your dark UI requirements
        home: const BottomNavigation(),
      ),
    ),
  );
}