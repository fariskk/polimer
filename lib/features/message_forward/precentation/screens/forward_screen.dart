import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polimer/features/message_forward/bloc/message_forward_bloc.dart';
import 'package:polimer/models/chat_list_model.dart';

class ForwardScreen extends StatelessWidget {
  ForwardScreen({super.key, required this.forwardMessage});

  List<Chatlist> selectedUser = [];
  List selectedIndex = [];
  Map forwardMessage;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageForwardBloc, MessageForwardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<MessageForwardBloc>().add(
                        ForwardButtonClickedEvent(
                            message: forwardMessage,
                            users: selectedUser,
                            context: context));
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ))
            ],
            backgroundColor: Color.fromARGB(255, 255, 111, 0),
            title: Text(
              "Forward To..",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.email!
                      .split("@")
                      .first)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List snapshotdata = snapshot.data["chatlist"];

                  if (snapshotdata.isNotEmpty) {
                    ChatList mychatlist =
                        ChatList.fromJson(snapshot.data!.data()!);

                    return ListView.builder(
                        itemCount: mychatlist.chatlist.length,
                        itemBuilder: (context, index) {
                          final userdata = mychatlist.chatlist[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  CachedNetworkImageProvider(userdata.image),
                            ),
                            title: Text(userdata.name),
                            trailing: selectedIndex.contains(index)
                                ? Icon(
                                    Icons.done_rounded,
                                    color: Colors.green,
                                  )
                                : SizedBox(),
                            onTap: () {
                              if (selectedIndex.contains(index)) {
                                selectedIndex.remove(index);
                                selectedUser.remove(userdata);
                                context
                                    .read<MessageForwardBloc>()
                                    .add(ReloadEvent());
                              } else {
                                selectedIndex.add(index);
                                selectedUser.add(userdata);
                                context
                                    .read<MessageForwardBloc>()
                                    .add(ReloadEvent());
                              }
                            },
                          );
                        });
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: Text("No Users"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
    );
    ;
  }
}
