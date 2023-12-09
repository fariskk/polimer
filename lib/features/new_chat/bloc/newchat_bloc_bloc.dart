import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'newchat_bloc_event.dart';
part 'newchat_bloc_state.dart';

class NewchatBlocBloc extends Bloc<NewchatBlocEvent, NewchatBlocState> {
  NewchatBlocBloc() : super(NewchatBlocInitial()) {
    on<SearchButtonClickedEvent>((event, emit) async {
      emit(SearchingState());
      List searchResult = [];
      final data = await FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: event.serachQueary)
          .get();
      searchResult = data.docs;
      emit(SerachSuccessState(searchResult: searchResult));
    });
    on<SerchCancelButtonClickedEvent>((event, emit) {
      emit(NewchatBlocInitial());
    });
    on<StartChatButtonClickedEvent>((event, emit) async {
      try {
        emit(LoadingState());
        final fir = FirebaseFirestore.instance.collection("users");
        late final myDetails;
        List myChatlist = [];
        late final otherPersondetails;
        List otherPersonChatlist = [];
        await fir.doc(event.myDocId).get().then((value) {
          myDetails = value.data();
          myChatlist = value.data()!["chatlist"];
        });
        await fir.doc(event.newPersonDocid).get().then((value) {
          otherPersondetails = value.data();
          otherPersonChatlist = value.data()!["chatlist"];
        });
        myChatlist.add({
          "name": otherPersondetails["username"],
          "type": "chat",
          "db": "${event.myDocId + event.newPersonDocid}",
          "image": otherPersondetails["profileimage"]
        });
        await fir.doc(event.myDocId).update({"chatlist": myChatlist});
        otherPersonChatlist.add({
          "name": myDetails["username"],
          "type": "chat",
          "db": "${event.myDocId + event.newPersonDocid}",
          "image": myDetails["profileimage"]
        });
        await fir
            .doc(event.newPersonDocid)
            .update({"chatlist": otherPersonChatlist});
        await FirebaseFirestore.instance
            .collection("messages")
            .doc("${event.myDocId + event.newPersonDocid}")
            .set({
          "messages": [],
          "lastmessage": "No Message Yet",
          "users": [event.myDocId, event.newPersonDocid]
        });
        var lastindexBox = Hive.box("lastindexBox");
        lastindexBox.put(event.newPersonDocid, 0);
        emit(StartChatSuccessState(
            username: event.newPersonDocid,
            db: "${event.myDocId + event.newPersonDocid}",
            profileImage: otherPersondetails["profileimage"]));
      } catch (e) {
        print(e);
        emit(StartChatfaildState());
      }
    });
  }
}
