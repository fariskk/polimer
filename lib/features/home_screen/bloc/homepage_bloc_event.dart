part of 'homepage_bloc_bloc.dart';

@immutable
sealed class HomepageBlocEvent {}

class DeleteChatedPerson extends HomepageBlocEvent {
  ChatList chatlist;
  int index;
  String chatedPersonName;
  DeleteChatedPerson(
      {required this.chatlist,
      required this.index,
      required this.chatedPersonName});
}
