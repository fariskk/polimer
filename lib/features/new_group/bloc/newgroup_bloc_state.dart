part of 'newgroup_bloc_bloc.dart';

@immutable
sealed class NewgroupBlocState {}

final class NewgroupBlocInitial extends NewgroupBlocState {}

class SearchingState extends NewgroupBlocState {}

class SerachSuccessState extends NewgroupBlocState {
  List searchResult;
  SerachSuccessState({required this.searchResult});
}

class StartChatSuccessState extends NewgroupBlocState {
  String username;
  String db;
  String profileImage;
  StartChatSuccessState(
      {required this.username, required this.db, required this.profileImage});
}

class StartChatfaildState extends NewgroupBlocState {}

class LoadingState extends NewgroupBlocState {}

class CreateGroupSuccessState extends NewgroupBlocState {
  Directory dir;
  String Username;
  String ProfileImage;
  String db;
  CreateGroupSuccessState(
      {required this.ProfileImage,
      required this.Username,
      required this.db,
      required this.dir});
}
