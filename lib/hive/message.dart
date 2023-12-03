import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 1)
class message {
  @HiveField(0)
  String sender;

  @HiveField(1)
  String senderImage;

  @HiveField(2)
  String time;

  @HiveField(3)
  String type;

  @HiveField(4)
  String content;

  message(
      {required this.content,
      required this.sender,
      required this.time,
      required this.senderImage,
      required this.type});
}
