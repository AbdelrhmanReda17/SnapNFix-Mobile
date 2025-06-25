import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snapnfix/presentation/navigation/shells/application_shell.dart';

class ApplicationBottomNavigationBar extends StatelessWidget {
  const ApplicationBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<NavigationItem> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.1),
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
          children: List.generate(items.length, (index) {
            final screen = items[index];
            final isSelected = selectedIndex == index;            return IconButton(
              isSelected: isSelected,
              onPressed: () => onItemSelected(index),
              icon: isDark 
                  ? SvgPicture.asset(
                      screen.icon,
                      colorFilter: ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                    )
                  : SvgPicture.asset(screen.icon),
              selectedIcon: SvgPicture.asset(
                isDark ? screen.darkActiveIcon : screen.activeIcon,
                colorFilter: isDark 
                    ? ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      )
                    : null,
              ),
            );
          }),
        ),
      ),
    );
  }
}
