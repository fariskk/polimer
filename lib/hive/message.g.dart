// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class messageAdapter extends TypeAdapter<message> {
  @override
  final int typeId = 1;

  @override
  message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return message(
      content: fields[4] as String,
      sender: fields[0] as String,
      time: fields[2] as String,
      senderImage: fields[1] as String,
      type: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, message obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sender)
      ..writeByte(1)
      ..write(obj.senderImage)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is messageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
