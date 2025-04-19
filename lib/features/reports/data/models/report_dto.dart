class ReportDTO {
  final String id;
  final String details;
  final double latitude;
  final double longitude;
  String imagePath;
  final String severity;
  final String timestamp;
  String? category;
  double? threshold;

  ReportDTO({
    required this.id,
    required this.details,
    required this.latitude,
    required this.longitude,
    required this.imagePath,
    required this.severity,
    required this.timestamp,
    this.category,
    this.threshold,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'details': details,
      'latitude': latitude,
      'longitude': longitude,
      'imagePath': imagePath,
      'severity': severity,
      'timestamp': timestamp,
      'category': category,
      'threshold': threshold,
    };
  }

  factory ReportDTO.fromJson(Map<String, dynamic> json) {
    return ReportDTO(
      id: json['id'] as String,
      details: json['details'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      imagePath: json['imagePath'] as String,
      severity: json['severity'] as String,
      timestamp: json['timestamp'] as String,
      category: json['category'] as String?,
      threshold: json['threshold'] as double?,
    );
  }
}
