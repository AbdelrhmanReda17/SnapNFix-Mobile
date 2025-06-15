// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_report_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineReportEntityAdapter extends TypeAdapter<OfflineReportEntity> {
  @override
  final int typeId = 0;

  @override
  OfflineReportEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineReportEntity(
      id: fields[0] as String,
      imagePath: fields[1] as String,
      comment: fields[2] as String?,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      severity: fields[5] as String?,
      createdAt: fields[6] as DateTime,
      isSynced: fields[7] as bool,
      city: fields[8] as String,
      road: fields[9] as String,
      state: fields[10] as String,
      country: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineReportEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.severity)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.isSynced)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.road)
      ..writeByte(10)
      ..write(obj.state)
      ..writeByte(11)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineReportEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
