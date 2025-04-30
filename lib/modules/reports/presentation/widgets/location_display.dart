import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LocationDisplay extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationDisplay({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  Future<String> _getAddressFromCoordinates() async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}';
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
    }
    return 'Location unavailable';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAddressFromCoordinates(),
      builder: (context, snapshot) {
        return Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                snapshot.data ?? 'Loading location...',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
