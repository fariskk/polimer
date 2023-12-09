// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatlisthive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class chatlisthiveAdapter extends TypeAdapter<chatlisthive> {
  @override
  final int typeId = 1;

  @override
  chatlisthive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return chatlisthive(
      hivechatlist: (fields[0] as List).cast<Chatlist>(),
    );
  }

  @override
  void write(BinaryWriter writer, chatlisthive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hivechatlist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is chatlisthiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
