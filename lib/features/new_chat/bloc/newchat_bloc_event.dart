part of 'newchat_bloc_bloc.dart';

@immutable
sealed class NewchatBlocEvent {}

class SearchButtonClickedEvent extends NewchatBlocEvent {
  String serachQueary;
  SearchButtonClickedEvent({required this.serachQueary});
}

class SerchCancelButtonClickedEvent extends NewchatBlocEvent {}

class StartChatButtonClickedEvent extends NewchatBlocEvent {
  String myDocId;
  String newPersonDocid;
  StartChatButtonClickedEvent(
      {required this.myDocId, required this.newPersonDocid});
}
