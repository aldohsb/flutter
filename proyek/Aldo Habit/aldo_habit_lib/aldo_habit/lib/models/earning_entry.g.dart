// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earning_entry.dart';

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
      date: fields[1] as DateTime,
      amount: fields[2] as double,
      note: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EarningEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.note);
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

class EarningGoalAdapter extends TypeAdapter<EarningGoal> {
  @override
  final int typeId = 4;

  @override
  EarningGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EarningGoal(
      monthlyTarget: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, EarningGoal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.monthlyTarget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EarningGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
