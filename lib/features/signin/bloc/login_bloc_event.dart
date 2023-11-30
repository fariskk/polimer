part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocEvent {}

class FloatingActionButtonClickedEvent extends LoginBlocEvent {
  String username;
  String password;
  FloatingActionButtonClickedEvent(this.username, this.password);
}
