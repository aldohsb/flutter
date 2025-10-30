// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hydration_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HydrationGoalAdapter extends TypeAdapter<HydrationGoal> {
  @override
  final int typeId = 1;

  @override
  HydrationGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HydrationGoal(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      icon: fields[3] as String,
      points: fields[4] as int,
      target: fields[5] as int,
      currentProgress: fields[6] as int,
      isCompleted: fields[7] as bool,
      startDate: fields[8] as DateTime,
      completedDate: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, HydrationGoal obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.points)
      ..writeByte(5)
      ..write(obj.target)
      ..writeByte(6)
      ..write(obj.currentProgress)
      ..writeByte(7)
      ..write(obj.isCompleted)
      ..writeByte(8)
      ..write(obj.startDate)
      ..writeByte(9)
      ..write(obj.completedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HydrationGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
