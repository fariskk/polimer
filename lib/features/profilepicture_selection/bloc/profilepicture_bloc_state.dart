part of 'profilepicture_bloc_bloc.dart';

@immutable
sealed class ProfilepictureBlocState {}

final class ProfilepictureBlocInitial extends ProfilepictureBlocState {}

class Loadingstate extends ProfilepictureBlocState {}

class LoadedState extends ProfilepictureBlocState {}

class Errorstate extends ProfilepictureBlocState {}
