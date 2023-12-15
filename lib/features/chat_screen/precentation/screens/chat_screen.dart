import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimer/features/chat_screen/bloc/chat_bloc_bloc.dart';

import 'package:polimer/features/chat_screen/precentation/widgets/chat_widgets.dart';
import 'package:polimer/features/files_selecton/precentaion/screens/file_selection_screen.dart';
import 'package:polimer/features/test/testscreen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:path_provider/path_provider.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {required this.username,
      required this.db,
      required this.profileImage,
      required this.dir});
  String username;
  String db;
  String profileImage;
  Directory dir;

  List messages = [];

  final _messageController = TextEditingController();

  ItemScrollController _chatScreenScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 31,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7.0, top: 13, bottom: 13),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  imageUrl: profileImage,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              username,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 255, 111, 0),
      ),
      body: Column(
        children: [
          BlocListener<ChatBlocBloc, ChatBlocState>(
            listener: (context, state) {
              if (state is DownloadingFaildState) {
                print("Faild to Download File");
              }
            },
            child: Container(),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("messages")
                      .doc(db)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      messages = snapshot.data["messages"];
                      var lastindexBox = Hive.box("lastindexBox");
                      int lastindex =
                          lastindexBox.get("${username}lastindex") ?? 0;
                      lastindexBox.put("${username}lastindex", messages.length);

                      return ScrollablePositionedList.builder(
                          initialScrollIndex: lastindex,
                          itemScrollController: _chatScreenScrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final messagedata = messages[index];

                            switch (messagedata["type"]) {
                              case "image":
                                return GestureDetector(
                                  onLongPress: () {},
                                  child: imageMessage(
                                      messagedata["content"],
                                      messagedata["time"],
                                      dir,
                                      messagedata["sender"],
                                      messagedata["senderimage"]),
                                );
                              case "video":
                                return GestureDetector(
                                  onLongPress: () {},
                                  child: videoMessage(
                                      messagedata["content"],
                                      messagedata["time"],
                                      dir,
                                      messagedata["sender"],
                                      messagedata["senderimage"]),
                                );
                              case "text":
                                return GestureDetector(
                                  onLongPress: () {},
                                  child: textMessage(
                                      messagedata["content"],
                                      messagedata["sender"],
                                      messagedata["time"],
                                      messagedata["senderimage"]),
                                );

                              default:
                                return Text(messagedata["content"]);
                            }
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
          BlocBuilder<ChatBlocBloc, ChatBlocState>(
            builder: (context, state) {
              return Container();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 111, 0), width: 1.8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 111, 0), width: 1.8)),
                  suffixIcon: Container(
                    width: 102,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              myBottomSheet(context, db, messages,
                                  _chatScreenScrollController);
                            },
                            icon: Icon(
                              Icons.file_copy,
                              color: Color.fromARGB(255, 255, 111, 0),
                            )),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 255, 111, 0),
                          ),
                          onPressed: () async {
                            if (_messageController.text != "") {
                              context.read<ChatBlocBloc>().add(
                                  SendButtonClickedEvent(
                                      context: context,
                                      messageController: _messageController,
                                      messages: messages,
                                      db: db,
                                      scrollcontroller:
                                          _chatScreenScrollController));
                            }
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
