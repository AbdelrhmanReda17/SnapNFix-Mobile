class AreaIssue {
  final String id;
  final String areaId;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  AreaIssue({
    required this.id,
    required this.areaId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'AreaIssue(id: $id, areaId: $areaId, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
