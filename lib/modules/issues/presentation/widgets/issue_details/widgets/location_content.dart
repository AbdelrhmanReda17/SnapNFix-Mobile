import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import './detail_item.dart';

class LocationContent extends StatelessWidget {
  final Issue issue;

  const LocationContent({
    super.key,
    required this.issue,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
        SizedBox(height: 8.h),
        DetailItem(label: 'Road', value: issue.road),
        DetailItem(label: 'City', value: issue.city),
        DetailItem(label: 'State', value: issue.state),
        DetailItem(label: 'Country', value: issue.country),
      ],
    );
  }
}