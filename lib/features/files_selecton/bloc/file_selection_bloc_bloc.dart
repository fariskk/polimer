import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'file_selection_bloc_event.dart';
part 'file_selection_bloc_state.dart';

class FileSelectionBlocBloc
    extends Bloc<FileSelectionBlocEvent, FileSelectionBlocState> {
  FileSelectionBlocBloc() : super(FileSelectionBlocInitial()) {
    on<BottomImageClickedEvent>((event, emit) {
      emit(FileSelectionBlocInitial());
    });
    on<CancelImageButtonClickedEvent>((event, emit) {
      emit(FileSelectionBlocInitial());
    });
    on<SendButtonClickedEvent>((event, emit) async {
      try {
        emit(UploadingState());
        final storageRef = FirebaseStorage.instance.ref();
        final imagesRef = storageRef.child(event.type);
        final dir = await getApplicationDocumentsDirectory();
        for (XFile file in event.files) {
          final fileRef = imagesRef.child(file.name);
          await fileRef.putFile(
            File(file.path),
          );

          String fileUrl = await fileRef.getDownloadURL();

          await File("${dir.path}/$fileUrl").create(recursive: true);
          await File(file.path).copy("${dir.path}/$fileUrl");
          final now = DateTime.now();
          String time = "${now.hour}:${now.minute}";
          event.messages.add({
            "content": fileUrl,
            "senderimage": FirebaseAuth.instance.currentUser!.photoURL,
            "sender":
                FirebaseAuth.instance.currentUser!.email!.split("@").first,
            "type": event.type,
            "time": time
          });
          FirebaseFirestore.instance
              .collection("messages")
              .doc(event.db)
              .update({"messages": event.messages});
        }
        event.scrollController.scrollTo(
            index: event.messages.length,
            duration: Duration(milliseconds: 500));
        emit(UploadSuccessState());
      } catch (e) {
        print(e);
        emit(UploadFaildState());
      }
    });
  }
}
