import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/user_reports_cubit.dart';

enum SortOption {
  dateNewest('dateNewest'),
  dateOldest('dateOldest');

  final String name;
  const SortOption(this.name);
}

class ReportsSortMenu extends StatelessWidget {
  final SortOption currentSortOption;

  const ReportsSortMenu({super.key, required this.currentSortOption});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    return PopupMenuButton<SortOption>(
      initialValue: currentSortOption,
      tooltip: localization.sort,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      icon: Icon(Icons.sort, color: colorScheme.primary),
      onSelected: (SortOption option) {
        context.read<UserReportsCubit>().loadReports(
          sortOption: option,
          refresh: true,
        );
      },
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<SortOption>>[
            _buildMenuItem(
              context,
              value: SortOption.dateNewest,
              text: localization.sortByDateNewest,
              icon: Icons.arrow_downward,
              isSelected: currentSortOption == SortOption.dateNewest,
            ),
            _buildMenuItem(
              context,
              value: SortOption.dateOldest,
              text: localization.sortByDateOldest,
              icon: Icons.arrow_upward,
              isSelected: currentSortOption == SortOption.dateOldest,
            ),
          ],
    );
  }

  PopupMenuItem<SortOption> _buildMenuItem(
    BuildContext context, {
    required SortOption value,
    required String text,
    required IconData icon,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopupMenuItem<SortOption>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          if (isSelected)
            Icon(Icons.check, size: 16.sp, color: colorScheme.primary),
        ],
      ),
    );
  }
}
