import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
