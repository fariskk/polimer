import 'package:hive/hive.dart';
import 'package:polimer/models/chat_list_model.dart';

part 'chatlisthive.g.dart';

@HiveType(typeId: 1)
class chatlisthive {
  @HiveField(0)
  List<Chatlist> hivechatlist;
  chatlisthive({required this.hivechatlist});
}
