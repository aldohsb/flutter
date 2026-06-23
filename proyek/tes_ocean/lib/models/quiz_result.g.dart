// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizResultAdapter extends TypeAdapter<QuizResult> {
  @override
  final int typeId = 1;

  @override
  QuizResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizResult(
      id: fields[0] as String,
      userId: fields[1] as String,
      completedAt: fields[2] as DateTime,
      opennessScore: fields[3] as double,
      conscientiousnessScore: fields[4] as double,
      extraversionScore: fields[5] as double,
      agreeablenessScore: fields[6] as double,
      neuroticismScore: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, QuizResult obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.completedAt)
      ..writeByte(3)
      ..write(obj.opennessScore)
      ..writeByte(4)
      ..write(obj.conscientiousnessScore)
      ..writeByte(5)
      ..write(obj.extraversionScore)
      ..writeByte(6)
      ..write(obj.agreeablenessScore)
      ..writeByte(7)
      ..write(obj.neuroticismScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
