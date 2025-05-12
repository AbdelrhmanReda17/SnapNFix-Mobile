enum ReportStatus {
  pending('Pending'),
  verified('Verified'),
  rejected('Rejected');

  final String value;
  const ReportStatus(this.value);

  bool get isActive => this == pending || this == pending;
  bool get isFinal => this == verified || this == rejected;

  static ReportStatus fromString(String value) {
    return ReportStatus.values.firstWhere(
      (status) => status.value.toLowerCase() == value.toLowerCase(),
      orElse: () => ReportStatus.pending,
    );
  }
}
