part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocEvent {}

class SendButtonClickedEvent extends ChatBlocEvent {
  List messages;
  TextEditingController messageController;
  BuildContext context;
  String db;
  ItemScrollController scrollcontroller;
  SendButtonClickedEvent(
      {required this.context,
      required this.messageController,
      required this.messages,
      required this.db,
      required this.scrollcontroller});
}

class DownloadImageButtonClickedEvent extends ChatBlocEvent {
  String content;
  DownloadImageButtonClickedEvent({required this.content});
}
