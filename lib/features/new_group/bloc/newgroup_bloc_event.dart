part of 'newgroup_bloc_bloc.dart';

@immutable
sealed class NewgroupBlocEvent {}

class SearchButtonClickedEvent extends NewgroupBlocEvent {
  String serachQueary;
  SearchButtonClickedEvent({required this.serachQueary});
}

class SerchCancelButtonClickedEvent extends NewgroupBlocEvent {}

class CreatGroupButtonClickedEvent extends NewgroupBlocEvent {
  List members;
  String imagepath;
  String name;
  CreatGroupButtonClickedEvent(
      {required this.members, required this.imagepath, required this.name});
}
