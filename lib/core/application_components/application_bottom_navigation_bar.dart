import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/application_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplicationBottomNavigationBar extends StatelessWidget {
  const ApplicationBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: .1),
            blurRadius: 10,
            offset: const Offset(0, -1), 
          ),
        ],
      ),
      child: BottomAppBar(
        height: 70.h,
        shape: const CircularNotchedRectangle(),
        color: colorScheme.surface,
        shadowColor: colorScheme.primary,
        surfaceTintColor: colorScheme.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(ApplicationScreens.navigationScreens.length, (
            index,
          ) {
            return IconButton(
              isSelected: selectedIndex == index,
              icon: SvgPicture.asset(
                ApplicationScreens.navigationScreens[index].icon!,
              ),
              selectedIcon: SvgPicture.asset(
                ApplicationScreens.navigationScreens[index].activeIcon!,
              ),
              onPressed: () => onItemSelected(index),
            );
          }),
        ),
      ),
    );
  }
}
