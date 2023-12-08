// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlogAdapter extends TypeAdapter<Blog> {
  @override
  final int typeId = 0;

  @override
  Blog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Blog(
      isFavorite: fields[4] as bool,
      date: fields[3] as String,
      title: fields[0] as String,
      imagePath: fields[1] as String,
      description: fields[2] as String,
      userIndex: fields[5] as int?,
      category: fields[6] as String?,
      key: fields[7] as String?,
      commentCount: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Blog obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.isFavorite)
      ..writeByte(5)
      ..write(obj.userIndex)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.key)
      ..writeByte(8)
      ..write(obj.commentCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
