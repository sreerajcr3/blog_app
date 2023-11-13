// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useridModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class useridAdapter extends TypeAdapter<userid> {
  @override
  final int typeId = 1;

  @override
  userid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return userid(
      name: fields[0] as String,
      username: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, userid obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is useridAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class commentDataAdapter extends TypeAdapter<commentData> {
  @override
  final int typeId = 4;

  @override
  commentData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return commentData(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, commentData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is commentDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class favoritesAdapter extends TypeAdapter<favorites> {
  @override
  final int typeId = 2;

  @override
  favorites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return favorites(
      isFavorite: fields[0] as bool,
      userIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, favorites obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isFavorite)
      ..writeByte(1)
      ..write(obj.userIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is favoritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
