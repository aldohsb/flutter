// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      id: fields[0] as String,
      name: fields[1] as String,
      sortOrder: fields[2] as int,
      completionLog: (fields[3] as Map).cast<String, bool>(),
      startDate: fields[4] as DateTime,
      createdAt: fields[5] as DateTime,
      // fields 6 & 7 are nullable — old data won't have them
      scheduledHour: fields[6] as int?,
      scheduledMinute: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sortOrder)
      ..writeByte(3)
      ..write(obj.completionLog)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.scheduledHour)
      ..writeByte(7)
      ..write(obj.scheduledMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}