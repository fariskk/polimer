part of 'newchat_bloc_bloc.dart';

@immutable
sealed class NewchatBlocState {}

final class NewchatBlocInitial extends NewchatBlocState {}

class SearchingState extends NewchatBlocState {}

class SerachSuccessState extends NewchatBlocState {
  List searchResult;
  SerachSuccessState({required this.searchResult});
}

class StartChatSuccessState extends NewchatBlocState {
  String username;
  String db;
  String profileImage;
  StartChatSuccessState(
      {required this.username, required this.db, required this.profileImage});
}

class StartChatfaildState extends NewchatBlocState {}

class LoadingState extends NewchatBlocState {}
