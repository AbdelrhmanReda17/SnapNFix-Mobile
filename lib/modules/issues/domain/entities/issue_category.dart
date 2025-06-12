enum IssueCategory {
  roadDamage('Road Damage'),
  defectiveManhole('Defective Manhole'),
  nonDefectiveManhole('Non-defective Manhole'),
  lighting('Lighting'),
  pothole('Pothole');

  final String displayName;
  const IssueCategory(this.displayName);

  @override
  String toString() => displayName;
}
