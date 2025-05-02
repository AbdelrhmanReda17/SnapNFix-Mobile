import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/presentation/components/application_bottom_navigation_bar.dart';
import 'package:snapnfix/presentation/components/application_floating_action_button.dart';
import 'package:snapnfix/presentation/components/application_system_ui_overlay.dart';
import 'package:snapnfix/presentation/components/network_connection_notifier.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class ApplicationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ApplicationShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appConfigs = ApplicationConfigurations.instance;
    final currentPath = GoRouterState.of(context).uri.toString();

    final effectiveIndex =
        navigationShell.currentIndex > 3 ? -1 : navigationShell.currentIndex;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _getStatusBarStyle(
        colorScheme,
        currentPath,
        appConfigs.isDarkMode,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: navigationShell),
              const NetworkConnectionNotifier(),
            ],
          ),
        ),
        bottomNavigationBar: ApplicationBottomNavigationBar(
          selectedIndex: effectiveIndex,
          onItemSelected: _onDestinationSelected,
          items: bottomItems, // Use bottomItems here
        ),
        floatingActionButton: ApplicationFloatingActionButton(
          onItemSelected: _onDestinationSelected,
          isActive: navigationShell.currentIndex == 4,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  SystemUiOverlayStyle _getStatusBarStyle(
    ColorScheme colorScheme,
    String currentPath,
    bool isDarkMode,
  ) {
    if (currentPath.contains(Routes.settings)) {
      return ApplicationSystemUIOverlay.getSettingsStyle(colorScheme.primary);
    }
    return ApplicationSystemUIOverlay.getDefaultStyle(isDarkMode);
  }

  static final _navigationItems = [
    const NavigationItem(
      icon: 'assets/icons/home.svg',
      activeIcon: 'assets/icons/active/home.svg',
      darkActiveIcon: 'assets/icons/active/Dhome.svg',
      label: 'Home',
      index: 0,
    ),
    const NavigationItem(
      icon: 'assets/icons/map.svg',
      activeIcon: 'assets/icons/active/map.svg',
      darkActiveIcon: 'assets/icons/active/Dmap.svg',
      label: 'Map',
      index: 1,
    ),
    const NavigationItem(
      icon: 'assets/icons/user_reports.svg',
      activeIcon: 'assets/icons/active/user_reports.svg',
      darkActiveIcon: 'assets/icons/active/Duser_reports.svg',
      label: 'Reports',
      index: 2,
    ),
    const NavigationItem(
      icon: 'assets/icons/settings.svg',
      activeIcon: 'assets/icons/active/settings.svg',
      darkActiveIcon: 'assets/icons/active/Dsettings.svg',
      label: 'Settings',
      index: 3,
    ),
  ];

  static List<NavigationItem> get bottomItems =>
      _navigationItems.where((item) => !item.isFloatingAction).toList();

  static NavigationItem get floatingItem =>
      _navigationItems.firstWhere((item) => item.isFloatingAction);
}

class NavigationItem {
  final String icon;
  final String activeIcon;
  final String darkActiveIcon;
  final String label;
  final int index;
  final bool isFloatingAction;

  const NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.darkActiveIcon,
    required this.label,
    required this.index,
    this.isFloatingAction = false,
  });
}
