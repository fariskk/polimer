import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

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
import 'package:social_media_recorder/screen/social_media_recorder.dart';

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
  List<XFile> clippedMessage = [];
  final _messageController = TextEditingController();

  ItemScrollController _chatScreenScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (messages.length == 0) {
                        return Center(
                          child: Text("No Chats"),
                        );
                      }
                      return ScrollablePositionedList.builder(
                          initialScrollIndex: lastindex,
                          itemScrollController: _chatScreenScrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final messagedata = messages[index];

                            switch (messagedata["type"]) {
                              case "image":
                                return GestureDetector(
                                  onLongPress: () {
                                    messagePopup(
                                        context,
                                        db,
                                        dir,
                                        messagedata["content"],
                                        index,
                                        messages,
                                        messagedata["type"],
                                        messagedata);
                                  },
                                  child: imageMessage(
                                      messagedata["content"],
                                      messagedata["time"],
                                      dir,
                                      messagedata["sender"],
                                      messagedata["senderimage"]),
                                );
                              case "clippedimage":
                                return GestureDetector(
                                  onLongPress: () {
                                    messagePopup(
                                        context,
                                        db,
                                        dir,
                                        messagedata["content"],
                                        index,
                                        messages,
                                        messagedata["type"],
                                        messagedata);
                                  },
                                  child: clippedImageMessage(
                                      messagedata["content"],
                                      messagedata["subcontent"],
                                      messagedata["time"],
                                      dir,
                                      messagedata["sender"],
                                      messagedata["senderimage"]),
                                );
                              case "video":
                                return GestureDetector(
                                  onLongPress: () {
                                    messagePopup(
                                        context,
                                        db,
                                        dir,
                                        messagedata["content"],
                                        index,
                                        messages,
                                        messagedata["type"],
                                        messagedata);
                                  },
                                  child: videoMessage(
                                      messagedata["content"],
                                      messagedata["time"],
                                      dir,
                                      messagedata["sender"],
                                      messagedata["senderimage"]),
                                );
                              case "text":
                                return GestureDetector(
                                  onLongPress: () {
                                    messagePopup(
                                        context,
                                        db,
                                        dir,
                                        messagedata["content"],
                                        index,
                                        messages,
                                        messagedata["type"],
                                        messagedata);
                                  },
                                  child: textMessage(
                                      messagedata["content"],
                                      messagedata["sender"],
                                      messagedata["time"],
                                      messagedata["senderimage"]),
                                );
                              case "audio":
                                return GestureDetector(
                                    onLongPress: () {
                                      messagePopup(
                                          context,
                                          db,
                                          dir,
                                          messagedata["content"],
                                          index,
                                          messages,
                                          messagedata["type"],
                                          messagedata);
                                    },
                                    child: audioMessage(
                                        messagedata["content"],
                                        messagedata["sender"],
                                        messagedata["senderimage"],
                                        messagedata["time"],
                                        context));

                              default:
                                return SizedBox();
                            }
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
          BlocBuilder<ChatBlocBloc, ChatBlocState>(
            builder: (context, state) {
              return Visibility(
                visible: clippedMessage.isNotEmpty,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                  child: clippedMessage.isNotEmpty
                      ? Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(2),
                              width: 100,
                              height: 100,
                              color: Color.fromARGB(255, 255, 111, 0),
                              child: Image.file(
                                File(clippedMessage.first.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            state is ClippedMessageUploadingState
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      clippedMessage.removeAt(0);
                                      context
                                          .read<ChatBlocBloc>()
                                          .add(ReloadEvent());
                                    },
                                    icon: Icon(Icons.cancel))
                          ],
                        )
                      : SizedBox(),
                ),
              );
            },
          ),
          BlocBuilder<ChatBlocBloc, ChatBlocState>(
            builder: (context, state) {
              if (state is VoiceRecordingState) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: SocialMediaRecorder(
                      backGroundColor: Colors.white,
                      stopRecording: (String time) {
                        context.read<ChatBlocBloc>().add(ReloadEvent());
                      },
                      sendRequestFunction: (File file, String time) {
                        context.read<ChatBlocBloc>().add(StopVoiceRecordEvent(
                            audioFile: file,
                            db: db,
                            scrollcontroller: _chatScreenScrollController,
                            messages: messages));
                      }),
                );
              }
              return SizedBox();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                  hintText: "Type your Message here..",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 111, 0), width: 1.8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 111, 0), width: 1.8)),
                  suffixIcon: Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            iconSize: 23,
                            onPressed: () {
                              myBottomSheet(context, db, messages,
                                  _chatScreenScrollController, clippedMessage);
                            },
                            icon: Icon(
                              Icons.file_copy,
                              color: Color.fromARGB(255, 255, 111, 0),
                            )),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<ChatBlocBloc>()
                                  .add(StartVoiceRecordEvent());
                            },
                            child: Icon(
                              Icons.mic,
                              color: Color.fromARGB(255, 255, 111, 0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 255, 111, 0),
                          ),
                          onPressed: () async {
                            if (_messageController.text != "" ||
                                clippedMessage.isNotEmpty) {
                              context.read<ChatBlocBloc>().add(
                                  SendButtonClickedEvent(
                                      context: context,
                                      messageController: _messageController,
                                      messages: messages,
                                      db: db,
                                      scrollcontroller:
                                          _chatScreenScrollController,
                                      clippedMessage: clippedMessage));
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
