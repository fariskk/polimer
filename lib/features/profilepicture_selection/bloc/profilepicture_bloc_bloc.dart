import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'profilepicture_bloc_event.dart';
part 'profilepicture_bloc_state.dart';

class ProfilepictureBlocBloc
    extends Bloc<ProfilepictureBlocEvent, ProfilepictureBlocState> {
  ProfilepictureBlocBloc() : super(ProfilepictureBlocInitial()) {
    on<ImageSelectedevent>((event, emit) async {
      emit(Loadingstate());
      try {
        final storageRef = FirebaseStorage.instance.ref();
        final userRef = storageRef
            .child(FirebaseAuth.instance.currentUser!.email!.split("@").first);
        final profileRef = userRef.child("profilePicture");
        await profileRef.putFile(
            File(event.imagePath), SettableMetadata(contentType: "image"));
        String profilePictureUrl = await profileRef.getDownloadURL();
        await FirebaseAuth.instance.currentUser!
            .updatePhotoURL(profilePictureUrl);
        emit(LoadedState());
      } catch (e) {
        emit(Errorstate());
      }
    });
  }
}
