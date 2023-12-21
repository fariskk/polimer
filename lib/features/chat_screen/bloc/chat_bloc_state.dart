part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocState {}

final class ChatBlocInitial extends ChatBlocState {}

class DownloadingState extends ChatBlocState {
  String content;
  double progress;
  DownloadingState({required this.content, required this.progress});
}

class DownloadingSuccessState extends ChatBlocState {}

class DownloadingFaildState extends ChatBlocState {}

class DeletingState extends ChatBlocState {}

class DeletingFaildState extends ChatBlocState {}

class DeletingSuccessState extends ChatBlocState {}

class ClippedMessageUploadingState extends ChatBlocState {}

class ClippedMessageUploadingsuccessState extends ChatBlocState {}

class VoiceRecordingState extends ChatBlocState {}

class VoiceUploadingState extends ChatBlocState {}
