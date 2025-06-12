class Marker {
  String issueId;
  double latitude;
  double longitude;

  Marker({
    required this.issueId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {'issueId': issueId, 'latitude': latitude, 'longitude': longitude};
  }

  factory Marker.fromJson(Map<String, dynamic> json) {
    return Marker(
      issueId: json['id'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}
