import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/connectivity/connectivity_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();
  // final AddReportRepository _reportRepository = getIt<AddReportRepository>();
  StreamSubscription? _connectivitySubscription;
  bool _previousConnectionStatus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupConnectivityMonitoring();
  }

  void _setupConnectivityMonitoring() {
    _connectivityService.monitorConnectivity(
      onStatusChanged: (isConnected) async {
        if (isConnected && !_previousConnectionStatus) {
          // await _reportRepository.syncPendingReports();
        }
        _previousConnectionStatus = isConnected;
      },
    );
    _connectivityService.isConnected().then((isConnected) {
      _previousConnectionStatus = isConnected;
    });
  }

  Future<void> _checkPendingReports() async {
    final isConnected = await _connectivityService.isConnected();
    if (isConnected) {
      // _reportRepository.syncPendingReports();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPendingReports();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            ElevatedButton(
              onPressed: () {
                getIt<ApplicationConfigurations>().logout();
              },
              child: const Text('Go to Another Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
