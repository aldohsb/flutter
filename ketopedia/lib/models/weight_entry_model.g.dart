// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightEntryModelAdapter extends TypeAdapter<WeightEntryModel> {
  @override
  final int typeId = 2;

  @override
  WeightEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightEntryModel(
      id: fields[0] as int?,
      userId: fields[1] as int,
      weight: fields[2] as double,
      date: fields[3] as DateTime,
      notes: fields[4] as String?,
      createdAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WeightEntryModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
