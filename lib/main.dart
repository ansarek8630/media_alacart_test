import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/campaign_detail_repo.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/forecast_repo.dart';

// Your existing imports
import 'package:media_alacart_test/app/features/campaign_list/presentation/bloc/campaign_event.dart';
import 'package:media_alacart_test/app/features/spend_summary_dashboard/data/repository/summary_repo.dart';
import 'package:media_alacart_test/app/features/spend_summary_dashboard/presentation/bloc/summary_bloc.dart';
import 'package:media_alacart_test/core/routes/app_router.dart';
import 'package:media_alacart_test/core/routes/app_routes.dart';
import 'app/features/campaign_list/data/repository/campaign_repo.dart';
import 'app/features/campaign_list/presentation/bloc/campaign_bloc.dart';



void main() {
  // 1. Initialize Network Client  
  final dio = Dio();

  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    // 2. MultiRepositoryProvider allows the AppRouter to fetch these on-demand
    return MultiRepositoryProvider(
      providers: [
        // Base repos for bottom nav screens
        RepositoryProvider(create: (_) => CampaignRepository(dio)),
        RepositoryProvider(create: (_) => SummaryRepository(dio)),
        RepositoryProvider(create: (_) => CampaignDetailRepository(dio)),
        RepositoryProvider(create: (_) => ForecastRepository(dio)),
      ],
      // 3. MultiBlocProvider for global states (Bottom Nav tabs)
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CampaignBloc>(
            // Use context.read to grab the repo provided just above
            create: (context) =>
                CampaignBloc(context.read<CampaignRepository>())
                  ..add(FetchCampaigns()),
          ),
          BlocProvider<SummaryBloc>(
            create: (context) =>
                SummaryBloc(context.read<SummaryRepository>())
                  ..add(LoadSummary("last_7_days")),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),

          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
