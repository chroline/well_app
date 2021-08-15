// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayModelAdapter extends TypeAdapter<DayModel> {
  @override
  final int typeId = 0;

  @override
  DayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayModel()
      ..gratitudes = (fields[1] as List).cast<String>()
      ..journal = fields[2] as String?
      ..acts = (fields[3] as List).cast<String>()
      ..exercise = fields[4] as int
      ..meditation = fields[5] as int
      ..date = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, DayModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.gratitudes)
      ..writeByte(2)
      ..write(obj.journal)
      ..writeByte(3)
      ..write(obj.acts)
      ..writeByte(4)
      ..write(obj.exercise)
      ..writeByte(5)
      ..write(obj.meditation)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
