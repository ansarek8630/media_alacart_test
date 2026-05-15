import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_alacart_test/app/features/bottom_nav/bottom_nav.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/screens/campaign_details.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/campaign_detail_repo.dart';
import 'package:media_alacart_test/app/features/campaign_details/data/repository/forecast_repo.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_bloc.dart';
import 'package:media_alacart_test/app/features/campaign_details/presentation/bloc/campaign_detail_event.dart';
import 'package:media_alacart_test/app/features/campaign_list/data/repository/campaign_repo.dart';
import 'package:media_alacart_test/core/routes/app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 1. The root route loads your existing Bottom Navigation
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());

      // 2. The detail route injects the BLoC specifically for that screen
      case AppRoutes.campaignDetail:
        final campaignId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CampaignDetailBloc(
              repository: context.read<CampaignDetailRepository>(),
              forecastRepo: context.read<ForecastRepository>(),
            )..add(LoadCampaignDetail(campaignId)),
            child: const CampaignDetailScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
