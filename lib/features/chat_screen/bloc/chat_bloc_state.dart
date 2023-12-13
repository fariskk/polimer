part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocState {}

final class ChatBlocInitial extends ChatBlocState {}

class DownloadingState extends ChatBlocState {}

class DownloadingSuccessState extends ChatBlocState {}

class DownloadingFaildState extends ChatBlocState {}
