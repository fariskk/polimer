import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:polimer/features/files_selecton/bloc/file_selection_bloc_bloc.dart';
import 'package:polimer/features/files_selecton/precentaion/widgets/file_selection_widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FileSelectionScreen extends StatelessWidget {
  FileSelectionScreen(
      {required this.files,
      required this.db,
      required this.messages,
      required this.scrollController,
      this.isvideo = false});

  List<XFile> files;
  int PreviewIndex = 0;
  String db;
  List messages;
  ItemScrollController scrollController;
  bool isvideo;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileSelectionBlocBloc, FileSelectionBlocState>(
      buildWhen: (preveious, current) => current is FileSelectionBlocInitial,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    if (files.isNotEmpty) {
                      context.read<FileSelectionBlocBloc>().add(
                          SendButtonClickedEvent(
                              files: files,
                              db: db,
                              messages: messages,
                              scrollController: scrollController,
                              type: isvideo ? "video" : "image"));
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ))
            ],
            toolbarHeight: 70,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.black,
            title: Text(
              "username",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black,
          body: BlocListener<FileSelectionBlocBloc, FileSelectionBlocState>(
            listenWhen: (previous, current) => current is UploadSuccessState,
            listener: (context, state) {
              if (state is UploadFaildState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Faild to upload file")));
              }

              if (state is UploadSuccessState) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: isvideo
                ? VideoPreview(
                    video: files[0],
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: InstaImageViewer(
                      disableSwipeToDismiss: true,
                      child: files.isNotEmpty
                          ? Center(
                              child: Image.file(
                                File(files[PreviewIndex].path),
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          : SizedBox(),
                    ),
                  ),
          ),
          bottomNavigationBar: isvideo
              ? SizedBox()
              : Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: files.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            PreviewIndex = index;
                            context
                                .read<FileSelectionBlocBloc>()
                                .add(BottomImageClickedEvent());
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.white,
                                )),
                                height: 80,
                                width: 80,
                                child: Image.file(
                                  File(files[index].path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              BlocBuilder<FileSelectionBlocBloc,
                                  FileSelectionBlocState>(
                                builder: (context, state) {
                                  if (state is UploadingState) {
                                    return CircularProgressIndicator(
                                      color: Color.fromARGB(255, 255, 111, 0),
                                    );
                                  }
                                  return Align(
                                    alignment: Alignment.topCenter,
                                    child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<FileSelectionBlocBloc>()
                                              .add(
                                                  CancelImageButtonClickedEvent());
                                          files.removeAt(index);
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          size: 25,
                                        )),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      }),
                ),
        );
      },
    );
  }
}
