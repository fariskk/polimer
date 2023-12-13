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
      event.messages.add({
        "content": event.messageController.text,
        "type": "text",
        "sender": FirebaseAuth.instance.currentUser!.email!.split("@").first,
        "senderimage": FirebaseAuth.instance.currentUser!.photoURL,
        "time": time
      });
      await fir.doc(event.db).update({"messages": event.messages});
      event.messageController.text = "";
      FocusScope.of(event.context).unfocus();
      event.scrollcontroller.scrollTo(
          index: event.messages.length, duration: Duration(seconds: 1));
    });

    on<DownloadImageButtonClickedEvent>((event, emit) async {
      emit(DownloadingState());
      final dir = await getApplicationDocumentsDirectory();
      Dio dio = Dio();
      dio.download(event.content, "${dir.path}/${event.content}");
    });
  }
}
