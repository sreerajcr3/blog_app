// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class categoryAdapter extends TypeAdapter<category> {
  @override
  final int typeId = 4;

  @override
  category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return category(
      all: fields[0] as Blog,
      nature: fields[1] as Blog?,
      science: fields[2] as Blog?,
      entertainement: fields[3] as Blog?,
      politics: fields[4] as Blog?,
    );
  }

  @override
  void write(BinaryWriter writer, category obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.all)
      ..writeByte(1)
      ..write(obj.nature)
      ..writeByte(2)
      ..write(obj.science)
      ..writeByte(3)
      ..write(obj.entertainement)
      ..writeByte(4)
      ..write(obj.politics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is categoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
