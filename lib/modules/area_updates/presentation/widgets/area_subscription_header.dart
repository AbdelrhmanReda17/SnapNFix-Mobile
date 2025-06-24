import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_state.dart';

class AreaSubscriptionHeader extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback? onAdd;

  const AreaSubscriptionHeader({
    super.key,
    required this.colorScheme,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Subscribed Areas',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onAdd,
              icon: Icon(
                Icons.add,
                size: 20.sp,
                color: colorScheme.primary,
              ),
            ),
            BlocBuilder<AreaSubscriptionCubit, AreaSubscriptionState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<AreaSubscriptionCubit>().refresh();
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 20.sp,
                    color: colorScheme.primary,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
