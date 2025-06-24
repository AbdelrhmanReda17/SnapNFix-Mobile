import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_state.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/area_tile.dart';

class AreasGridView extends StatelessWidget {
  final List<AreaInfo> areas;
  final ColorScheme colorScheme;
  final Function(String) onToggleSubscription;

  const AreasGridView({
    super.key,
    required this.areas,
    required this.colorScheme,
    required this.onToggleSubscription,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final area = areas[index];
          return BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
            builder: (context, subscriptionState) {
              final isSubscribed = context
                  .read<AreaSubscriptionCubit>()
                  .isSubscribedToArea(area.name);

              return AreaTile(
                area: area,
                isSubscribed: isSubscribed,
                colorScheme: colorScheme,
                onToggleSubscription: () => onToggleSubscription(area.name),
              );
            },
          );
        },
        childCount: areas.length,
      ),
    );
  }
}
