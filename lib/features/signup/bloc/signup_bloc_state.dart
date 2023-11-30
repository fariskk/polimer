part of 'signup_bloc_bloc.dart';

@immutable
sealed class SignupBlocState {}

final class SignupBlocInitial extends SignupBlocState {}

class userNameAvailableStete extends SignupBlocState {}

class UsernameCheckingstate extends SignupBlocState {}

class UserNameNotAvailableStete extends SignupBlocState {
  String message;
  UserNameNotAvailableStete(this.message);
}

class LoadingState extends SignupBlocState {}

class PasswordDonotMatchError extends SignupBlocState {}

class SignupFaildState extends SignupBlocState {}

class SignupSuccessState extends SignupBlocState {}
