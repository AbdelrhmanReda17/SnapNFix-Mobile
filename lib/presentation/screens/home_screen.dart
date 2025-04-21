import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/offline_report_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OfflineReportIndicator(),
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
