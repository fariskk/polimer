part of 'profilepicture_bloc_bloc.dart';

@immutable
sealed class ProfilepictureBlocEvent {}

class ImageSelectedevent extends ProfilepictureBlocEvent {
  String imagePath;
  ImageSelectedevent(this.imagePath);
}
