import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/presentation/cubits/channels_cubit.dart';
import 'package:snapnfix/presentation/cubits/channels_state.dart';

class ChannelsSection extends StatelessWidget {
  const ChannelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChannelsCubit(),
      child: const _ChannelsSectionContent(),
    );
  }
}

class _ChannelsSectionContent extends StatelessWidget {
  const _ChannelsSectionContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localization = AppLocalizations.of(context)!;

    return BlocBuilder<ChannelsCubit, ChannelsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                localization.channels,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
            verticalSpace(2),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children:
                    state.channels.map((channel) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: ChannelButton(
                          label: channel,
                          isSelected: channel == state.selectedChannel,
                          onTap:
                              () => context.read<ChannelsCubit>().selectChannel(
                                channel,
                              ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    _buildChannelHeader(context, colorScheme),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh:
                            () =>
                                context.read<ChannelsCubit>().refreshUpdates(),
                        color: colorScheme.primary,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: 8.h,
                          ),
                          itemCount:
                              context
                                  .read<ChannelsCubit>()
                                  .getFilteredUpdates()
                                  .length,
                          itemBuilder: (context, index) {
                            final updates =
                                context
                                    .read<ChannelsCubit>()
                                    .getFilteredUpdates();
                            final update = updates[index];
                            return GestureDetector(
                              onTap:
                                  () => context
                                      .read<ChannelsCubit>()
                                      .navigateToIssueDetails(
                                        context,
                                        update.id,
                                      ),
                              child: _buildUpdateItem(
                                context,
                                update,
                                colorScheme,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChannelHeader(BuildContext context, ColorScheme colorScheme) {
    final cubit = context.read<ChannelsCubit>();
    final state = cubit.state;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outline.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${state.selectedChannel} Updates',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  state.isSubscribed
                      ? Icons.notifications_active
                      : Icons.notifications_none,
                  color: colorScheme.primary,
                ),
                onPressed: () => cubit.toggleSubscription(),
              ),
              PopupMenuButton<IssueStatus?>(
                icon: Icon(
                  Icons.filter_list,
                  color:
                      state.selectedStatuses.isEmpty
                          ? colorScheme.primary
                          : colorScheme.primary.withValues(alpha: 0.5),
                ),
                offset: Offset(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                itemBuilder:
                    (context) => [
                      ...IssueStatus.values.map(
                        (status) => PopupMenuItem<IssueStatus>(
                          value: status,
                          height: 40,
                          child: Row(
                            children: [
                              Icon(
                                state.selectedStatuses.contains(status)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: status.color,
                                size: 20.r,
                              ),
                              horizontalSpace(8.w),
                              Text(
                                status.displayName,
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (state.selectedStatuses.isNotEmpty) ...[
                        PopupMenuItem(
                          height: 32,
                          enabled: false,
                          padding: EdgeInsets.zero,
                          child: Divider(height: 1),
                        ),
                        PopupMenuItem<IssueStatus?>(
                          height: 40,
                          value: null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.clear_all,
                                color: colorScheme.error,
                                size: 18.r,
                              ),
                              horizontalSpace(8.w),
                              Text(
                                AppLocalizations.of(context)!.clearFilters,
                                style: TextStyle(
                                  color: colorScheme.error,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                onSelected: (status) {
                  if (status == null) {
                    cubit.clearFilters();
                  } else {
                    cubit.toggleStatusFilter(status);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(
    BuildContext context,
    IssueUpdate update,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: update.status.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              update.status.icon,
              color: update.status.color,
              size: 20.r,
            ),
          ),
          horizontalSpace(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.issueDetails(update.id),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  update.status.displayName,
                  style: TextStyle(fontSize: 12.sp, color: update.status.color),
                ),
              ],
            ),
          ),
          Text(
            update.time,
            style: TextStyle(
              fontSize: 12.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class ChannelButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ChannelButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color:
          isSelected
              ? colorScheme.primary.withValues(alpha: 0.7)
              : colorScheme.primary,
      borderRadius: BorderRadius.circular(24.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color:
                  isSelected
                      ? Colors.transparent
                      : colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}
