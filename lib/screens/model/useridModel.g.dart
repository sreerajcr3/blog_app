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
      profilePic: fields[5] as String?,
      userIndex: fields[4] as int?,
      likedBlogs: fields[3] as String?,
      name: fields[0] as String?,
      username: fields[1] as String?,
      password: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, userid obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.likedBlogs)
      ..writeByte(4)
      ..write(obj.userIndex)
      ..writeByte(5)
      ..write(obj.profilePic);
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
      blogIndex: fields[0] as int,
      userIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, favorites obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.blogIndex)
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
