import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, required this.video, required this.dir});
  String video;
  Directory dir;
  @override
  State<VideoPlayerScreen> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoController;
  late CustomVideoPlayerController customVideoPlayerController;
  @override
  void initState() {
    videoController =
        VideoPlayerController.file(File("${widget.dir.path}/${widget.video}"))
          ..initialize().then((value) {
            setState(() {});
          });
    customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoController);
    super.initState();
  }

  @override
  void dispose() {
    customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Center(
        child: AspectRatio(
          aspectRatio: videoController.value.aspectRatio,
          child: CustomVideoPlayer(
              customVideoPlayerController: customVideoPlayerController),
        ),
      ),
    );
  }
}
