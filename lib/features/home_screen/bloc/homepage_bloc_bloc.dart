import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:polimer/models/chat_list_model.dart';

part 'homepage_bloc_event.dart';
part 'homepage_bloc_state.dart';

class HomepageBlocBloc extends Bloc<HomepageBlocEvent, HomepageBlocState> {
  HomepageBlocBloc() : super(HomepageBlocInitial()) {
    on<DeleteChatedPerson>((event, emit) async {
      var lastindexBox = Hive.box("lastindexBox");
      await lastindexBox.delete("${event.chatedPersonName}lastindex");

      String myDocid =
          FirebaseAuth.instance.currentUser!.email!.split("@").first;
      final fir = FirebaseFirestore.instance.collection("users");
      event.chatlist.chatlist.removeAt(event.index);
      await fir.doc(myDocid).update(event.chatlist.toJson());
    });
  }
}
