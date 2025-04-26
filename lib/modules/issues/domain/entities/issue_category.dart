enum IssueCategory {
  roadDamage('Road Damage'),
  defectivePothole('Defective Pothole'),
  lighting('Lighting'),
  manhole('Manhole');

  final String displayName;
  const IssueCategory(this.displayName);

  @override
  String toString() => displayName;
}
