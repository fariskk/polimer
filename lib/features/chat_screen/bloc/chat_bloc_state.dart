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
