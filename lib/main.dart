import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/campaign_detail_repo.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/forecast_repo.dart';
import 'package:media_alacart_test/app/features/campaign_list/presentation/bloc/campaign_event.dart';
import 'package:media_alacart_test/app/features/spend_summary_dashboard/data/repository/summary_repo.dart';
import 'package:media_alacart_test/app/features/spend_summary_dashboard/presentation/bloc/summary_bloc.dart';
import 'package:media_alacart_test/core/routes/app_router.dart';
import 'package:media_alacart_test/core/routes/app_routes.dart';
import 'app/features/campaign_list/data/repository/campaign_repo.dart';
import 'app/features/campaign_list/presentation/bloc/campaign_bloc.dart';

void main() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://e5eb0d84-2b7e-4c32-98b9-233668b4e189.mock.pstmn.io/v1',
    ),
  );
  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CampaignRepository(dio)),
        RepositoryProvider(create: (_) => SummaryRepository(dio)),
        RepositoryProvider(create: (_) => CampaignDetailRepository(dio)),
        RepositoryProvider(create: (_) => ForecastRepository(dio)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CampaignBloc>(
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
