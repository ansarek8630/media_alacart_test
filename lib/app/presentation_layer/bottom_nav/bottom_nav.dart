import 'package:flutter/material.dart';
import 'package:media_alacart_test/app/presentation_layer/campaign_list/presentation/screens/campaign_list.dart';

import '../../../core/theme/app_colors.dart';
import '../spend_summary_dashboard/presentation/screens/spend_summary_dashboard.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final _pages = [
    CampaignListPage(),
    SummaryScreen(),
    // AnomalyAlertsPage(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) => states.contains(WidgetState.selected)
                ? const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.navActive,
                  )
                : const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.navInactive,
                  ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: AppColors.appBar,
          indicatorColor: Colors.transparent,
          elevation: 0,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) => setState(() => _selectedIndex = i),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.campaign_outlined, color: AppColors.navInactive),
              selectedIcon: Icon(Icons.campaign, color: AppColors.navActive),
              label: 'Campaigns',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bar_chart_outlined,
                color: AppColors.navInactive,
              ),
              selectedIcon: Icon(Icons.bar_chart, color: AppColors.navActive),
              label: 'Spend Summary',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.navInactive,
              ),
              selectedIcon: Icon(
                Icons.notifications,
                color: AppColors.navActive,
              ),
              label: 'Alerts',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: AppColors.navInactive),
              selectedIcon: Icon(Icons.person, color: AppColors.navActive),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
