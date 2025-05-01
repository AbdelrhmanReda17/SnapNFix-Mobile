import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';

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
        if (place.street?.isNotEmpty == true || place.locality?.isNotEmpty == true) {
          return '${place.street ?? ''}, ${place.locality ?? ''}'.trim().replaceAll(RegExp(r'^,\s*'), '');
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Platform error getting address: ${e.message}');
      // Return coordinates when offline or other platform errors
      return '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
    } catch (e) {
      debugPrint('Error getting address: $e');
    }
    // Fallback to coordinates if geocoding fails
    return '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAddressFromCoordinates(),
      builder: (context, snapshot) {
        String displayText = snapshot.data ?? 'Loading location...';
        if (snapshot.hasError) {
          displayText = '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
        }
        
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
                displayText,
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
