// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earning_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EarningEntryAdapter extends TypeAdapter<EarningEntry> {
  @override
  final int typeId = 3;

  @override
  EarningEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EarningEntry(
      id: fields[0] as String,
      amount: fields[1] as double,
      note: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, EarningEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EarningEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MonthlyEarningGoalAdapter extends TypeAdapter<MonthlyEarningGoal> {
  @override
  final int typeId = 4;

  @override
  MonthlyEarningGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyEarningGoal(
      monthlyTargets: (fields[0] as Map).cast<String, double>(),
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyEarningGoal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.monthlyTargets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyEarningGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
