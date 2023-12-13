import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, required this.videoUrl});
  String videoUrl;
  @override
  State<VideoPlayerScreen> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoController;
  late CustomVideoPlayerController customVideoPlayerController;
  @override
  void initState() {
    videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        setState(() {});
      });
    customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: videoController.value.aspectRatio,
              child: CustomVideoPlayer(
                  customVideoPlayerController: customVideoPlayerController),
            ),
          ),
        ],
      ),
    );
  }
}
