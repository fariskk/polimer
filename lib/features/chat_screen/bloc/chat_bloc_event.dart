part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocEvent {}

class SendButtonClickedEvent extends ChatBlocEvent {
  List messages;
  TextEditingController messageController;
  BuildContext context;
  String db;
  List<XFile> clippedMessage;
  ItemScrollController scrollcontroller;
  SendButtonClickedEvent(
      {required this.context,
      required this.messageController,
      required this.messages,
      required this.db,
      required this.scrollcontroller,
      required this.clippedMessage});
}

class DownloadImageButtonClickedEvent extends ChatBlocEvent {
  String content;
  DownloadImageButtonClickedEvent({required this.content});
}

class DownloadVideoButtonClickedEvent extends ChatBlocEvent {
  String content;
  BuildContext context;
  DownloadVideoButtonClickedEvent(
      {required this.content, required this.context});
}

class DeleteMessageButtonClickedEvent extends ChatBlocEvent {
  List messages;
  String db;
  int index;
  Directory dir;
  String filepath;
  String type;
  DeleteMessageButtonClickedEvent({
    required this.db,
    required this.dir,
    required this.filepath,
    required this.index,
    required this.messages,
    required this.type,
  });
}

class ReloadEvent extends ChatBlocEvent {}

class StartVoiceRecordEvent extends ChatBlocEvent {}

class StopVoiceRecordEvent extends ChatBlocEvent {
  File audioFile;
  String db;
  ItemScrollController scrollcontroller;
  List messages;
  StopVoiceRecordEvent(
      {required this.audioFile,
      required this.db,
      required this.scrollcontroller,
      required this.messages});
}
