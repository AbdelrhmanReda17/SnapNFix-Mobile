import 'package:snapnfix/modules/reports/domain/entities/report.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

class FastReport extends Report {
  final String comment;
  final bool isUserReport;

  const FastReport({
    super.id,
    required String issueId,
    required this.comment,
    required ReportSeverity severity,
    this.isUserReport = false,
    super.createdAt,
  }) : super(issueId: issueId, severity: severity);

  @override
  List<Object?> get props => [...super.props, comment, isUserReport];
}
