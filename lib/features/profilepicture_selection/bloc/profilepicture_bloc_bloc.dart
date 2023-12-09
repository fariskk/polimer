import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        String myDocid =
            FirebaseAuth.instance.currentUser!.email!.split("@").first;
        final storageRef = FirebaseStorage.instance.ref();
        final userRef = storageRef.child(myDocid);
        final profileRef = userRef.child("profilePicture");
        await profileRef.putFile(
            File(event.imagePath), SettableMetadata(contentType: "image"));
        String profilePictureUrl = await profileRef.getDownloadURL();
        await FirebaseAuth.instance.currentUser!
            .updatePhotoURL(profilePictureUrl);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(myDocid)
            .update({"profileimage": profilePictureUrl});

        emit(LoadedState());
      } catch (e) {
        emit(Errorstate());
      }
    });
  }
}
