// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      username: fields[0] as String,
      createdAt: fields[1] as DateTime,
      currentLevel: fields[2] as int,
      totalStars: fields[3] as int,
      totalCorrect: fields[4] as int,
      totalQuestions: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.currentLevel)
      ..writeByte(3)
      ..write(obj.totalStars)
      ..writeByte(4)
      ..write(obj.totalCorrect)
      ..writeByte(5)
      ..write(obj.totalQuestions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LevelProgressAdapter extends TypeAdapter<LevelProgress> {
  @override
  final int typeId = 1;

  @override
  LevelProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LevelProgress(
      levelNumber: fields[0] as int,
      username: fields[6] as String,
      correctAnswers: fields[1] as int,
      totalAttempts: fields[2] as int,
      stars: fields[3] as int,
      isCompleted: fields[4] as bool,
      completedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LevelProgress obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.levelNumber)
      ..writeByte(1)
      ..write(obj.correctAnswers)
      ..writeByte(2)
      ..write(obj.totalAttempts)
      ..writeByte(3)
      ..write(obj.stars)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.completedAt)
      ..writeByte(6)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
