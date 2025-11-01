// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationSettingModelAdapter
    extends TypeAdapter<NotificationSettingModel> {
  @override
  final int typeId = 3;

  @override
  NotificationSettingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationSettingModel(
      id: fields[0] as int?,
      userId: fields[1] as int,
      time: fields[2] as String,
      isEnabled: fields[3] as bool,
      createdAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationSettingModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.isEnabled)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
