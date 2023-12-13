import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimer/features/files_selecton/bloc/file_selection_bloc_bloc.dart';

class VideoPreview extends StatefulWidget {
  VideoPreview({super.key, required this.video});
  XFile video;
  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController videoController;
  late CustomVideoPlayerController customVideoPlayerController;
  @override
  void initState() {
    videoController = VideoPlayerController.file(File(widget.video.path))
      ..initialize().then((value) {
        setState(() {});
      });
    customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: CustomVideoPlayer(
                customVideoPlayerController: customVideoPlayerController),
          ),
        ),
        BlocBuilder<FileSelectionBlocBloc, FileSelectionBlocState>(
          builder: (context, state) {
            if (state is UploadingState) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 111, 0),
              ));
            }
            return SizedBox();
          },
        )
      ],
    );
  }
}
