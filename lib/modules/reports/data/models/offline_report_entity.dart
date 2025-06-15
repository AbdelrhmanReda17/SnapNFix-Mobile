import 'package:hive_flutter/hive_flutter.dart';

part 'offline_report_entity.g.dart';

@HiveType(typeId: 0)
class OfflineReportEntity extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String imagePath;

  @HiveField(2)
  String? comment;

  @HiveField(3)
  late double latitude;

  @HiveField(4)
  late double longitude;

  @HiveField(5)
  String? severity;

  @HiveField(6)
  late DateTime createdAt;

  @HiveField(7)
  late bool isSynced;

  @HiveField(8)
  late String city;

  @HiveField(9)
  late String road;

  @HiveField(10)
  late String state;

  @HiveField(11)
  late String country;

  OfflineReportEntity({
    required this.id,
    required this.imagePath,
    this.comment,
    required this.latitude,
    required this.longitude,
    this.severity,
    required this.createdAt,
    this.isSynced = false,
    required this.city,
    required this.road,
    required this.state,
    required this.country,
  });
}
