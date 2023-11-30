part of 'signup_bloc_bloc.dart';

@immutable
sealed class SignupBlocEvent {}

class usernamefieldUnfocusEvent extends SignupBlocEvent {
  String userName;
  usernamefieldUnfocusEvent(this.userName);
}

class FloatingActionButtonClickedEvent extends SignupBlocEvent {
  String userName;
  String password;
  String conformPassword;
  FloatingActionButtonClickedEvent(
      this.userName, this.password, this.conformPassword);
}
