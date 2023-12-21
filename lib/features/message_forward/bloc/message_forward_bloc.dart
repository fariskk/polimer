import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:polimer/models/chat_list_model.dart';

part 'message_forward_event.dart';
part 'message_forward_state.dart';

class MessageForwardBloc
    extends Bloc<MessageForwardEvent, MessageForwardState> {
  MessageForwardBloc() : super(MessageForwardInitial()) {
    on<ReloadEvent>((event, emit) {
      emit(MessageForwardInitial());
    });

    on<ForwardButtonClickedEvent>((event, emit) async {
      final fir = FirebaseFirestore.instance.collection("messages");
      for (Chatlist chat in event.users) {
        final userdata = await fir.doc(chat.db).get();
        List oldMessages = userdata.data()!["messages"];
        event.message["sender"] =
            FirebaseAuth.instance.currentUser!.email!.split("@").first;
        event.message["senderimage"] =
            FirebaseAuth.instance.currentUser!.photoURL;
        oldMessages.add(event.message);
        await fir.doc(chat.db).update({"messages": oldMessages});
        Navigator.pop(event.context);
        Navigator.pop(event.context);
      }
    });
  }
}
