import 'package:flutter/material.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

class LocationDisplay extends StatelessWidget {
  final String? road;
  final String? city;
  final String? state;
  final String? country;

  const LocationDisplay({
    super.key,
    this.road,
    this.city,
    this.state,
    this.country,
  });

  bool get _hasLocationData {
    return road != null || city != null || state != null || country != null;
  }

  String _buildAddressString() {
    final parts = <String>[];

    if (road != null && road!.isNotEmpty) {
      parts.add(road!);
    }

    if (city != null && city!.isNotEmpty) {
      parts.add(city!);
    }

    if (state != null && state!.isNotEmpty) {
      parts.add(state!);
    }

    if (country != null && country!.isNotEmpty) {
      parts.add(country!);
    }

    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    // Don't show the widget if we don't have any location data
    if (!_hasLocationData) {
      return const SizedBox.shrink();
    }

    final displayText = _buildAddressString();

    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        horizontalSpace(4),
        Expanded(
          child: Text(
            displayText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
