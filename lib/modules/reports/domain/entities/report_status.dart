enum ReportStatus {
  pending('Pending'),
  valid('Valid'),
  invalid('Invalid');

  final String value;
  const ReportStatus(this.value);
}
