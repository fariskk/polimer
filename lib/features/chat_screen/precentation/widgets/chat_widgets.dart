import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polimer/features/chat_screen/precentation/screens/video_player_screen.dart';
import 'package:polimer/features/files_selecton/precentaion/screens/file_selection_screen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Widget myImage(String content, String time) {
  File? file = null;

  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100),
      padding: const EdgeInsets.only(top: 6, left: 5, right: 10, bottom: 0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 247, 168, 108),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.amber,
              child: file != null
                  ? Image.file(file)
                  : Center(
                      child: IconButton(
                        onPressed: () async {
                          print(file);
                          final dir = await getApplicationDocumentsDirectory();
                          file = File(dir.path + "/" + "uiuiggy");
                          print(file);
                        },
                        icon: Icon(Icons.download),
                      ),
                    ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 11),
          )
        ],
      ),
    ),
  );
}

Widget myMessage(
    String content, String time, String type, BuildContext context) {
  if (type == "text") {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100),
        padding: const EdgeInsets.only(top: 6, left: 5, right: 10, bottom: 0),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 247, 168, 108),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text(content, style: const TextStyle(fontSize: 17)),
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  } else {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100),
        padding: const EdgeInsets.only(top: 6, left: 5, right: 10, bottom: 0),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 247, 168, 108),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: type == "image"
                    ? myImage(content, time)
                    : IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(
                                        videoUrl: content,
                                      )));
                        },
                        icon: const Icon(Icons.play_arrow))),
            Text(
              time,
              style: const TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}

Widget otherPersonMessage(String message, String time, String type) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 100, left: 5),
      padding: const EdgeInsets.only(top: 6, left: 10, right: 5, bottom: 8),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 247, 168, 108),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(message, style: const TextStyle(fontSize: 17)),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 11),
          )
        ],
      ),
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
                    XFile? video =
                        await picker.pickVideo(source: ImageSource.gallery);
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
