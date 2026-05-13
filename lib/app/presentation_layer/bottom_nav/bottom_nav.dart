import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/presentation_layer/campaign_list/campaign_list.dart';

import '../../../constant/app_colors.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final _pages = [
    CampaignListPage(),
    CampaignListPage(),
    CampaignListPage(),
    CampaignListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.appBar,
        indicatorColor: AppColors.appBar,
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
            icon: Icon(Icons.bar_chart_outlined, color: AppColors.navInactive),
            selectedIcon: Icon(Icons.bar_chart, color: AppColors.navActive),
            label: 'Spend Summary',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.navInactive,
            ),
            selectedIcon: Icon(Icons.notifications, color: AppColors.navActive),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: AppColors.navInactive),
            selectedIcon: Icon(Icons.person, color: AppColors.navActive),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
