import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@singleton
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final _internetStatusController = StreamController<bool>.broadcast();
  Timer? _pollingTimer;
  bool _lastStatus = false;

  Stream<List<ConnectivityResult>> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((result) {
      debugPrint(
        '🌐 Connectivity: Status changed to: ${_getReadableStatus(result)}',
      );
      return result;
    });
  }

  Stream<bool> get getNetworkStream {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 120), (_) {
      hasInternetConnection().then(_updateConnectionStatus);
    });

    return _connectivity.onConnectivityChanged
        .asyncMap((_) => hasInternetConnection())
        .distinct()
        .asBroadcastStream();
  }

  void _updateConnectionStatus(bool isConnected) {
    if (isConnected != _lastStatus) {
      _lastStatus = isConnected;
      _internetStatusController.add(isConnected);
      debugPrint('🌐 Connectivity: Internet status changed to: $isConnected');
    }
  }


  Future<List<ConnectivityResult>> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result;
  }


  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      debugPrint(
        '🌐 Connectivity: Checking internet connection, current status: ${_getReadableStatus(connectivityResult)}',
      );
      if (connectivityResult.contains(ConnectivityResult.none)) {
        debugPrint('🌐 Connectivity: No radio connectivity available');
        return false;
      }
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('🌐 Connectivity: Internet connection confirmed');
        return true;
      }
      debugPrint('🌐 Connectivity: No internet connection detected');
      return false;
    } on SocketException catch (_) {
      debugPrint('🌐 Connectivity: Socket exception - no internet connection');
      return false;
    } catch (e) {
      debugPrint('🌐 Connectivity: Error checking internet connection: $e');
      return false;
    }
  }

  Future<bool> isConnected() async {
    return await hasInternetConnection();
  }

  String _getReadableStatus(List<ConnectivityResult> result) {
    if (result.isEmpty) {
      return 'No connection';
    }
    if (result.contains(ConnectivityResult.mobile)) {
      return 'Mobile data';
    } else if (result.contains(ConnectivityResult.wifi)) {
      return 'WiFi';
    } else if (result.contains(ConnectivityResult.ethernet)) {
      return 'Ethernet';
    } else if (result.contains(ConnectivityResult.bluetooth)) {
      return 'Bluetooth';
    } else if (result.contains(ConnectivityResult.vpn)) {
      return 'VPN';
    }
    return 'Unknown connection type';
  }

  void monitorConnectivity({
    required Function(bool isConnected) onStatusChanged,
  }) {
    debugPrint('🌐 Connectivity: Setting up connectivity monitor');
    connectivityStream.listen((result) async {
      final hasInternet = await hasInternetConnection();
      onStatusChanged(hasInternet);
    });
  }
}
