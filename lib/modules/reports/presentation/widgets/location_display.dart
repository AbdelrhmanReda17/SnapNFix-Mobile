import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';

class LocationDisplay extends StatefulWidget {
  final double latitude;
  final double longitude;

  const LocationDisplay({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<LocationDisplay> createState() => _LocationDisplayState();
}

class _LocationDisplayState extends State<LocationDisplay> {
  static final Map<String, String> _addressCache = {};
  static const int _maxRetries = 2;
  static const Duration _initialTimeout = Duration(seconds: 5);
  
  String get _cacheKey => '${widget.latitude}_${widget.longitude}';

  Future<String> _getAddressWithRetry([int retryCount = 0]) async {
    try {
      final timeout = _initialTimeout * (retryCount + 1);
      final placemarks = await placemarkFromCoordinates(
        widget.latitude, 
        widget.longitude,
      ).timeout(timeout);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        if (place.street?.isNotEmpty == true || place.locality?.isNotEmpty == true) {
          final address = [
            place.street,
            place.locality,
            place.administrativeArea,
          ].where((e) => e?.isNotEmpty == true).join(', ');
          
          _addressCache[_cacheKey] = address;
          return address;
        }
      }
      throw Exception('No valid address found');
      
    } on TimeoutException catch (e) {
      debugPrint('Geocoding timeout (attempt ${retryCount + 1}): $e');
      if (retryCount < _maxRetries) {
        // Exponential backoff before retry
        await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));
        return _getAddressWithRetry(retryCount + 1);
      }
      return _getFallbackAddress();
      
    } on PlatformException catch (e) {
      debugPrint('Platform error getting address: ${e.message}');
      return _getFallbackAddress();
      
    } catch (e) {
      debugPrint('Error getting address: $e');
      if (retryCount < _maxRetries) {
        await Future.delayed(Duration(milliseconds: 500 * (retryCount + 1)));
        return _getAddressWithRetry(retryCount + 1);
      }
      return _getFallbackAddress();
    }
  }

  Future<String> _getAddressFromCoordinates() async {
    // Check cache first
    if (_addressCache.containsKey(_cacheKey)) {
      return _addressCache[_cacheKey]!;
    }
    return _getAddressWithRetry();
  }

  String _getFallbackAddress() {
    final coords = '${widget.latitude.toStringAsFixed(6)}, ${widget.longitude.toStringAsFixed(6)}';
    _addressCache[_cacheKey] = coords;
    return coords;
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAddressFromCoordinates(),
      builder: (context, snapshot) {
        String displayText = snapshot.data ?? 'Loading location...';
        if (snapshot.hasError) {
          displayText = _getFallbackAddress();
        }
        
        return Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
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
      },
    );
  }
}
