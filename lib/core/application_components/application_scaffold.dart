import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_components/application_bottom_navigation_bar.dart';
import 'package:snapnfix/core/application_components/application_floating_action_button.dart';
import 'package:snapnfix/core/theming/colors.dart';

class BaseScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BaseScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = navigationShell.currentIndex;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ApplicationBottomNavigationBar(
          selectedIndex: selectedIndex,
          onItemSelected: (index) {
            navigationShell.goBranch(index);
          },
        ),

        floatingActionButton: ApplicationFloatingActionButton(
          isActive: selectedIndex == 4,
          onItemSelected: (index) {
            navigationShell.goBranch(index);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: SafeArea(child: navigationShell),
      ),
    );
  }
}
