part of 'file_selection_bloc_bloc.dart';

@immutable
sealed class FileSelectionBlocEvent {}

class BottomImageClickedEvent extends FileSelectionBlocEvent {}

class SendButtonClickedEvent extends FileSelectionBlocEvent {
  List<XFile> files;
  String db;
  List messages;
  String type;
  ItemScrollController scrollController;
  SendButtonClickedEvent(
      {required this.files,
      required this.db,
      required this.messages,
      required this.type,
      required this.scrollController});
}

class CancelImageButtonClickedEvent extends FileSelectionBlocEvent {}
