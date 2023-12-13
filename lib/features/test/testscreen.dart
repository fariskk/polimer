import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class testscreen extends StatefulWidget {
  const testscreen({Key? key}) : super(key: key);

  @override
  State<testscreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<testscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            Dio d = Dio();
            final dir = await getApplicationDocumentsDirectory();
            print(File(dir.path + "/" + "test").existsSync());
            print("------");
            print(await File(dir.path + "/" + "test").exists());
            await d.download(
                "https://firebasestorage.googleapis.com/v0/b/polimer-8a4e9.appspot.com/o/username5%2FprofilePicture?alt=media&token=375895ca-e457-4cb8-98ef-e311a0783401",
                dir.path + "/" + "test");

            print(File(dir.path + "/" + "test").existsSync());
            print("------");
            print(await File(dir.path + "/" + "test").exists());
          },
        ),
      ),
    );
  }
}

String videoUrlLandscape =
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
String videoUrlPortrait =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
String longVideo =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

String video720 =
    "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4";

String video480 =
    "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_10mb.mp4";

String video240 =
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_10mb.mp4";
