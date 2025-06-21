import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationPermissionWidget extends StatefulWidget {
  final Widget Function(Position position) builder;
  final String message;

  const LocationPermissionWidget({
    super.key,
    required this.builder,
    this.message = 'This feature requires location access',
  });

  @override
  State<LocationPermissionWidget> createState() =>
      _LocationPermissionWidgetState();
}

class _LocationPermissionWidgetState extends State<LocationPermissionWidget>
    with WidgetsBindingObserver {
  final _locationService = LocationService();
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusSubscription;
  Position? _currentPosition;
  bool _isLocationEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeLocation();
    _listenToServiceStatus();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _serviceStatusSubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    if (!mounted) return;

    setState(() => _isLoading = true);
    await _checkLocationStatus();
    if (_isLocationEnabled) {
      await _getCurrentPosition();
      _setupLocationStream();
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _listenToServiceStatus() {
    _serviceStatusSubscription?.cancel();
    _serviceStatusSubscription = Geolocator.getServiceStatusStream().listen((
      status,
    ) {
      if (mounted) {
        if (status == ServiceStatus.enabled) {
          _initializeLocation();
        } else {
          setState(() {
            _isLocationEnabled = false;
            _currentPosition = null;
          });
        }
      }
    });
  }

  Future<void> _getCurrentPosition() async {
    try {
      _currentPosition = await _locationService.getCurrentPosition();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error getting current position: $e');
    }
  }

  Future<void> _checkLocationStatus() async {
    final isServiceEnabled =
        await _locationService.checkIfLocationServiceEnabled();
    final hasPermission = await _locationService.hasLocationPermission();
    if (mounted) {
      setState(() {
        _isLocationEnabled = isServiceEnabled && hasPermission;
      });
    }
  }

  void _setupLocationStream() {
    _positionStreamSubscription?.cancel();
    if (_isLocationEnabled) {
      _positionStreamSubscription = _locationService.onLocationChanged().listen(
        (position) {
          if (mounted) {
            setState(() => _currentPosition = position);
          }
        },
        onError: (error) {
          debugPrint('Location stream error: $error');
          if (mounted) {
            setState(() {
              _isLocationEnabled = false;
              _currentPosition = null;
            });
          }
        },
      );
    }
  }

  Future<void> _requestLocationPermission() async {
    setState(() => _isLoading = true);

    await _locationService.checkLocationPermissions(
      onPermissionDenied: (title, permanent) async {
        if (permanent) {
          await _locationService.openAppSettings();
        }
      },
      onServiceDisabled: () async {
        await _locationService.openLocationSettings();
        return true;
      },
    );

    await _initializeLocation();
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context)!;
    
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(localization.gettingYourLocation),
          ],
        ),
      );
    }

    if (!_isLocationEnabled || _currentPosition == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_off, size: 60, color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                widget.message,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              BaseButton(
                onPressed: _requestLocationPermission,
                text: 'Enable Location',
                textStyle: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return widget.builder(_currentPosition!);
  }
}
