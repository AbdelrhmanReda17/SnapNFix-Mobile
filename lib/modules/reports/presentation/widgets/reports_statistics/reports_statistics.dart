import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_statistics_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/reports_statistics/statistics_cards.dart';

class ReportsStatistics extends StatelessWidget {
  const ReportsStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReportStatisticsCubit>()..loadStatistics(),
      child: const StatisticsCards(),
    );
  }
}
