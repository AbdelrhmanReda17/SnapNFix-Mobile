import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Stream for listening to connectivity changes
  Stream<List<ConnectivityResult>> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((result) {
      debugPrint(
        '🌐 Connectivity: Status changed to: ${_getReadableStatus(result)}',
      );
      return result;
    });
  }

  // Check current connectivity status (radio status only)
  // Warning: This only gives you the radio status, not actual internet connectivity
  Future<List<ConnectivityResult>> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result;
  }

  // Properly check if there is actual internet connectivity
  // This performs an actual network request to verify connectivity
  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
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

  // Check connectivity reliably (for use in app logic)
  Future<bool> isConnected() async {
    return await hasInternetConnection();
  }

  // Convert ConnectivityResult to a readable string
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
