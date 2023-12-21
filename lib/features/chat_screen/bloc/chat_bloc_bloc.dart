import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polimer/features/files_selecton/bloc/file_selection_bloc_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatBlocInitial()) {
    on<SendButtonClickedEvent>((event, emit) async {
      final now = DateTime.now();
      String time = "${now.hour}:${now.minute}";
      final fir = FirebaseFirestore.instance.collection("messages");
      if (event.clippedMessage.isNotEmpty) {
        emit(ClippedMessageUploadingState());
        final storageRef = FirebaseStorage.instance.ref();
        final imagesRef = storageRef.child("image");
        final dir = await getApplicationDocumentsDirectory();

        final fileRef = imagesRef.child(event.clippedMessage.first.name);
        await fileRef.putFile(
          File(event.clippedMessage.first.path),
        );
        String fileUrl = await fileRef.getDownloadURL();
        await File("${dir.path}/$fileUrl").create(recursive: true);
        await File(event.clippedMessage.first.path)
            .copy("${dir.path}/$fileUrl");
        event.messages.add({
          "content": fileUrl,
          "type": "clippedimage",
          "subcontent": event.messageController.text,
          "sender": FirebaseAuth.instance.currentUser!.email!.split("@").first,
          "senderimage": FirebaseAuth.instance.currentUser!.photoURL,
          "time": time
        });
        event.clippedMessage.removeAt(0);
        event.scrollcontroller.scrollTo(
            index: event.messages.length, duration: Duration(seconds: 1));
        emit(ClippedMessageUploadingsuccessState());
      } else {
        event.messages.add({
          "content": event.messageController.text,
          "type": "text",
          "sender": FirebaseAuth.instance.currentUser!.email!.split("@").first,
          "senderimage": FirebaseAuth.instance.currentUser!.photoURL,
          "time": time
        });
      }
      await fir.doc(event.db).update({"messages": event.messages});
      event.messageController.text = "";
      FocusScope.of(event.context).unfocus();
      event.scrollcontroller.scrollTo(
          index: event.messages.length, duration: Duration(seconds: 1));
    });

    on<DownloadImageButtonClickedEvent>((event, emit) async {
      emit(DownloadingState(content: event.content, progress: 0.0));
      final dir = await getApplicationDocumentsDirectory();
      Dio dio = Dio();

      await dio.download(event.content, "${dir.path}/${event.content}",
          onReceiveProgress: (a, b) {
        emit(DownloadingState(content: event.content, progress: a / b));
      });

      emit(DownloadingSuccessState());
    });

    on<DownloadVideoButtonClickedEvent>((event, emit) async {
      try {
        emit(DownloadingState(content: event.content, progress: 0.0));
        final dir = await getApplicationDocumentsDirectory();
        Dio dio = Dio();

        await dio.download(
          event.content,
          "${dir.path}/${event.content}",
          onReceiveProgress: (a, b) {
            emit(DownloadingState(content: event.content, progress: a / b));
          },
        );

        emit(DownloadingSuccessState());
      } catch (e) {
        final dir = await getApplicationDocumentsDirectory();
        await File("${dir.path}/${event.content}").delete();

        emit(DownloadingFaildState());
      }
    });

    on<DeleteMessageButtonClickedEvent>((event, emit) async {
      try {
        emit(DeletingState());
        if (File("${event.dir.path}/${event.filepath}").existsSync() &&
            event.type != "text") {
          await File("${event.dir.path}/${event.filepath}").delete();
        }
        final fir = FirebaseFirestore.instance.collection("messages");
        event.messages.removeAt(event.index);
        await fir.doc(event.db).update({"messages": event.messages});
        emit(DeletingSuccessState());
      } catch (e) {
        print(e);
        emit(DeletingFaildState());
      }
    });

    on<ReloadEvent>((event, emit) {
      emit(ChatBlocInitial());
    });
    on<StartVoiceRecordEvent>((event, emit) {
      emit(VoiceRecordingState());
    });

    on<StopVoiceRecordEvent>((event, emit) async {
      emit(VoiceUploadingState());

      final now = DateTime.now();
      String time = "${now.hour}:${now.minute}";
      final fir = FirebaseFirestore.instance.collection("messages");
      final storageRef = FirebaseStorage.instance.ref();
      final audioRef = storageRef.child("audio/${event.db}/$now");
      await audioRef.putFile(event.audioFile);
      String fileUrl = await audioRef.getDownloadURL();

      event.messages.add({
        "content": fileUrl,
        "sender": FirebaseAuth.instance.currentUser!.email!.split("@").first,
        "senderimage": FirebaseAuth.instance.currentUser!.photoURL,
        "time": time,
        "type": "audio"
      });
      await fir.doc(event.db).update({"messages": event.messages});
      event.scrollcontroller.scrollTo(
          index: event.messages.length, duration: Duration(seconds: 1));
      emit(ChatBlocInitial());
    });
  }
}
