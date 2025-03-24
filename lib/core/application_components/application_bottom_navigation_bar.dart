import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snapnfix/core/theming/colors.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryColor.withOpacity(0.02),
            blurRadius: 10, // Blur makes shadow more realistic
            offset: const Offset(0, -5), // Moves shadow **upwards**
          ),
        ],
      ),
      child: BottomAppBar(
        height: 70.h,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        shadowColor: ColorsManager.primaryColor,
        surfaceTintColor: ColorsManager.whiteColor,
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
