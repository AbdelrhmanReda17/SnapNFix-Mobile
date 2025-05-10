import 'package:snapnfix/modules/reports/domain/entities/report.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'dart:io';

class ReportModel extends Report {
  const ReportModel({
    required super.id,
    required super.details,
    required super.latitude,
    required super.longitude,
    required super.severity,
    required super.timestamp,
    required super.image,
    required super.issueId,
    super.category,
    super.threshold,
    super.status = ReportStatus.pending,
  });

  ReportModel copyWith({
    String? id,
    String? details,
    double? latitude,
    double? longitude,
    ReportSeverity? severity,
    String? timestamp,
    File? image,
    String? category,
    double? threshold,
    ReportStatus? status,
    String? issueId,
  }) {
    return ReportModel(
      id: id ?? this.id,
      details: details ?? this.details,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
      image: image ?? this.image,
      category: category ?? this.category,
      threshold: threshold ?? this.threshold,
      status: status ?? this.status,
      issueId: issueId ?? this.issueId,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'details': details,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity.toString(),
      'timestamp': timestamp,
      'image': image.path,
      'category': category,
      'threshold': threshold,
      'status': status.toString(),
      'issueId': issueId,
    };
  }

  // fromJson
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      details: json['details'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      severity: ReportSeverity.values.firstWhere(
        (e) => e.toString() == json['severity'],
      ),
      timestamp: json['timestamp'] as String,
      image: File(json['image'] as String),
      category: json['category'] as String?,
      threshold: (json['threshold'] as num?)?.toDouble(),
      status: ReportStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      issueId: json['issueId'] as String,
    );
  }
}
