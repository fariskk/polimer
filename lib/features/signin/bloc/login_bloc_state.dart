part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocState {}

final class LoginBlocInitial extends LoginBlocState {}

class LoadingState extends LoginBlocState {}

class SigninSuccessState extends LoginBlocState {}

class SigninFaildState extends LoginBlocState {
  String errorMessage;
  SigninFaildState(this.errorMessage);
}
