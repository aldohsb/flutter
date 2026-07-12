// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calorie_entry.dart';

class CalorieEntryAdapter extends TypeAdapter<CalorieEntry> {
  @override
  final int typeId = 5;

  @override
  CalorieEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalorieEntry(
      id: fields[0] as String,
      foodName: fields[1] as String,
      calories: fields[2] as int,
      date: fields[3] as DateTime,
      quantity: fields[4] as int? ?? 1,
    );
  }

  @override
  void write(BinaryWriter writer, CalorieEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.foodName)
      ..writeByte(2)
      ..write(obj.calories)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalorieEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CalorieGoalAdapter extends TypeAdapter<CalorieGoal> {
  @override
  final int typeId = 6;

  @override
  CalorieGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalorieGoal(
      dailyTargetKcal: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CalorieGoal obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dailyTargetKcal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalorieGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CustomFoodAdapter extends TypeAdapter<CustomFood> {
  @override
  final int typeId = 7;

  @override
  CustomFood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomFood(
      id: fields[0] as String,
      name: fields[1] as String,
      caloriesPerServing: fields[2] as int,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CustomFood obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.caloriesPerServing)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomFoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}