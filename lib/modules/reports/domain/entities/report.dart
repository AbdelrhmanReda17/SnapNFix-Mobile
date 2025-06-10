import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:snapnfix/core/utils/helpers/image_builder.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';
import 'package:geocoding/geocoding.dart';

class Report extends Equatable {
  final String? id;
  final String? issueId;
  final String? details;
  final double latitude;
  final double longitude;
  final DateTime? createdAt;
  final String imagePath;
  final String? category;
  final ReportSeverity? severity;
  final ReportStatus? status;
  const Report({
    this.id,
    this.issueId,
    this.details,
    required this.latitude,
    required this.longitude,
    this.createdAt,
    required this.imagePath,
    this.category,
    this.severity = ReportSeverity.low,
    this.status = ReportStatus.pending,
  });

  File get image => File(imagePath);
  bool get hasValidImagePath => ImageBuilder.isValidImagePath(imagePath);

  bool get isVerified => status == ReportStatus.approved;
  bool get isPending => status == ReportStatus.pending;
  bool get isRejected => status == ReportStatus.declined;

  bool get isHighSeverity => severity == ReportSeverity.high;
  bool get isMediumSeverity => severity == ReportSeverity.medium;
  bool get isLowSeverity => severity == ReportSeverity.low;

  bool get timeToLive {
    if (createdAt == null) return false;
    final now = DateTime.now();
    final difference = now.difference(createdAt!);
    return difference.inHours < 24;
  }

  String get dateString {
    if (createdAt == null) return '';
    final now = DateTime.now();
    final difference = now.difference(createdAt!);
    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else {
      return '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}';
    }
  }

  Future<String> get locationString async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        if (place.street?.isNotEmpty == true ||
            place.locality?.isNotEmpty == true) {
          final address = [
            place.street,
            place.locality,
            place.administrativeArea,
          ].where((e) => e?.isNotEmpty == true).join(', ');
          return address;
        }
      }
      return '$latitude $longitude';
    } catch (e) {
      return '$latitude $longitude';
    }
  }

  @override
  List<Object?> get props => [
    id,
    issueId,
    details,
    latitude,
    longitude,
    createdAt,
    imagePath,
    category,
    severity,
    status,
  ];
}
