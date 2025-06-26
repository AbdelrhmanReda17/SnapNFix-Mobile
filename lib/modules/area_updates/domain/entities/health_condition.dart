enum HealthCondition {
  poor('Poor'),
  average('Average'),
  good('Good'),
  excellent('Excellent');

  final String displayName;
  const HealthCondition(this.displayName);
}
