import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:polimer/features/chat_screen/bloc/chat_bloc_bloc.dart';
import 'package:polimer/features/chat_screen/precentation/screens/video_player_screen.dart';

import 'package:polimer/features/files_selecton/precentaion/screens/file_selection_screen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Widget imageMessage(String content, String time, Directory dir, String sender,
    String senderimage) {
  String myUsername =
      FirebaseAuth.instance.currentUser!.email!.split("@").first;
  return Align(
    alignment:
        sender == myUsername ? Alignment.centerRight : Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 220,
          height: 300,
          margin: sender == myUsername
              ? const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100)
              : const EdgeInsets.only(top: 8, bottom: 8, right: 100, left: 5),
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 250, 216, 185),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sender,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 53, 52, 82)),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 11),
                  )
                ],
              ),
              BlocBuilder<ChatBlocBloc, ChatBlocState>(
                buildWhen: (Prervious, current) =>
                    current is DownloadingState && current.content == content ||
                    current is DownloadingSuccessState,
                builder: (context, state) {
                  if (state is DownloadingState) {
                    return Container(
                      height: 250,
                      width: 200,
                      child: Center(
                          child: CircularProgressIndicator(
                        value: state.progress,
                      )),
                    );
                  }
                  return Container(
                    width: 200,
                    height: 250,
                    child: File("${dir.path}/$content").existsSync()
                        ? InstaImageViewer(
                            disableSwipeToDismiss: true,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.file(
                                filterQuality: FilterQuality.high,
                                File("${dir.path}/$content"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Center(
                            child: IconButton(
                              onPressed: () async {
                                context.read<ChatBlocBloc>().add(
                                    DownloadImageButtonClickedEvent(
                                        content: content));
                              },
                              icon: const Icon(
                                Icons.download,
                                size: 50,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
        sender != myUsername
            ? CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  senderimage,
                ),
              )
            : SizedBox(),
      ],
    ),
  );
}

Widget videoMessage(String content, String time, Directory dir, String sender,
    String senderimage) {
  String myUsername =
      FirebaseAuth.instance.currentUser!.email!.split("@").first;
  return Align(
    alignment:
        sender == myUsername ? Alignment.centerRight : Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          width: 220,
          margin: sender == myUsername
              ? const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100)
              : const EdgeInsets.only(top: 8, bottom: 8, right: 100, left: 5),
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 250, 216, 185),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sender,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 53, 52, 82)),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 11),
                  )
                ],
              ),
              SizedBox(
                height: 3,
              ),
              BlocBuilder<ChatBlocBloc, ChatBlocState>(
                buildWhen: (Prervious, current) =>
                    current is DownloadingState && current.content == content ||
                    current is DownloadingSuccessState,
                builder: (context, state) {
                  if (state is DownloadingState) {
                    return Container(
                      height: 250,
                      width: 200,
                      child: Center(
                          child: CircularProgressIndicator(
                        value: state.progress,
                      )),
                    );
                  }
                  return Container(
                    width: 200,
                    height: 250,
                    color: File("${dir.path}/$content").existsSync()
                        ? Colors.black
                        : const Color.fromARGB(255, 250, 216, 185),
                    child: File("${dir.path}/$content").existsSync()
                        ? IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(
                                          video: content, dir: dir)));
                            },
                            icon: const Icon(
                              Icons.play_circle,
                              size: 55,
                              color: Colors.white,
                            ))
                        : Center(
                            child: IconButton(
                              onPressed: () async {
                                context.read<ChatBlocBloc>().add(
                                    DownloadVideoButtonClickedEvent(
                                        context: context, content: content));
                              },
                              icon: const Icon(
                                Icons.play_circle,
                                size: 55,
                                color: Colors.black,
                              ),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
        sender != myUsername
            ? CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(senderimage),
              )
            : SizedBox(),
      ],
    ),
  );
}

Widget textMessage(
    String content, String sender, String time, String senderimage) {
  String myUsername =
      FirebaseAuth.instance.currentUser!.email!.split("@").first;
  return Align(
    alignment:
        sender == myUsername ? Alignment.centerRight : Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: sender == myUsername
              ? const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100)
              : const EdgeInsets.only(top: 8, bottom: 8, right: 100, left: 5),
          padding: const EdgeInsets.only(top: 6, left: 7, right: 7, bottom: 0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 252, 203, 158),
            borderRadius: sender == myUsername
                ? const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))
                : const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sender,
                style: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 53, 52, 82)),
              ),
              Text(content, style: const TextStyle(fontSize: 17)),
              Text(
                time,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
        sender != myUsername
            ? CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(senderimage),
              )
            : SizedBox(),
      ],
    ),
  );
}

myBottomSheet(BuildContext context, String db, List messages,
    ItemScrollController scrollController) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  label: const Text("Send Video"),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    XFile? video = await picker.pickVideo(
                      source: ImageSource.gallery,
                    );
                    if (video != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FileSelectionScreen(
                                    files: [video],
                                    db: db,
                                    messages: messages,
                                    scrollController: scrollController,
                                    isvideo: true,
                                  )));
                    }
                  },
                  icon: const Icon(Icons.video_camera_front)),
              TextButton.icon(
                  label: const Text("Send Image"),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    List<XFile> images = await picker.pickMultiImage();

                    if (images.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FileSelectionScreen(
                                    files: images,
                                    db: db,
                                    messages: messages,
                                    scrollController: scrollController,
                                  )));
                    }
                  },
                  icon: const Icon(Icons.image))
            ],
          ),
        );
      });
}
