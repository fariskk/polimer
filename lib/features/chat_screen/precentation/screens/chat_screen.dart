import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:polimer/features/chat_screen/precentation/widgets/chat_widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:path_provider/path_provider.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {required this.username, required this.db, required this.profileImage});
  String username;
  String db;
  String profileImage;

  List messages = [];

  final _messageController = TextEditingController();

  ItemScrollController _chatScreenScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final appDocumentsDir = await getTemporaryDirectory();
        print(appDocumentsDir.path);

        print(appDocumentsDir);
      }),
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
                            if (messagedata["sender"] ==
                                FirebaseAuth.instance.currentUser!.email!
                                    .split("@")
                                    .first) {
                              return myMessage(
                                  messagedata["content"], messagedata["time"]);
                            } else {
                              return otherPersonMessage(
                                  messagedata["content"], messagedata["time"]);
                            }
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
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
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      color: Colors.amber,
                                      height: 200,
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.attach_file,
                              color: Color.fromARGB(255, 255, 111, 0),
                            )),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 255, 111, 0),
                          ),
                          onPressed: () async {
                            final now = DateTime.now();
                            String time = "${now.hour}:${now.minute}";
                            final fir = FirebaseFirestore.instance
                                .collection("messages");
                            messages.add({
                              "content": _messageController.text,
                              "type": "text",
                              "sender": FirebaseAuth
                                  .instance.currentUser!.email!
                                  .split("@")
                                  .first,
                              "senderimage":
                                  FirebaseAuth.instance.currentUser!.photoURL,
                              "time": time
                            });
                            await fir.doc(db).update({"messages": messages});
                            _messageController.text = "";
                            FocusScope.of(context).unfocus();
                            _chatScreenScrollController.scrollTo(
                                index: messages.length,
                                duration: Duration(seconds: 1));
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
