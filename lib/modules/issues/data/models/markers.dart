class IssueMarker {
  String issueId;
  double latitude;
  double longitude;

  IssueMarker({
    required this.issueId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {'issueId': issueId, 'latitude': latitude, 'longitude': longitude};
  }

  factory IssueMarker.fromJson(Map<String, dynamic> json) {
    return IssueMarker(
      issueId: json['id'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}
