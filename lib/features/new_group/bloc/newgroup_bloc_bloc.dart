import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'newgroup_bloc_event.dart';
part 'newgroup_bloc_state.dart';

class NewgroupBlocBloc extends Bloc<NewgroupBlocEvent, NewgroupBlocState> {
  NewgroupBlocBloc() : super(NewgroupBlocInitial()) {
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
      emit(NewgroupBlocInitial());
    });
    on<CreatGroupButtonClickedEvent>((event, emit) async {
      final meessageRef = FirebaseFirestore.instance.collection("messages");
      final userRef = FirebaseFirestore.instance.collection("users");
      final storageRef = FirebaseStorage.instance.ref();
      String dbName = meessageRef.doc().id;
      final groupRef = storageRef.child(dbName);
      final profileRef = groupRef.child("profileimage");
      await profileRef.putFile(File(event.imagepath));
      String profileUrl = await profileRef.getDownloadURL();
      Map groupDetails = {
        "db": dbName,
        "image": profileUrl,
        "name": event.name,
        "type": "group"
      };
      await meessageRef
          .doc(dbName)
          .set({"lastmessage": "No Message Yet", "messages": [], "users": []});
      for (var user in event.members) {
        final userdata = await userRef.doc(user["username"]).get();
        List oldChats = userdata.data()!["chatlist"];
        oldChats.add(groupDetails);
        await userRef.doc(user["username"]).update({"chatlist": oldChats});
      }
    });
  }
}
