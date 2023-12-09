import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polimer/features/account_screen/precentation/screens/account_screen.dart';
import 'package:polimer/features/home_screen/precentation/widgets/homeScreen_widgets.dart';

import 'package:polimer/features/new_chat/precentation/screens/newchat_screen.dart';
import 'package:polimer/features/new_group/precentation/newgroup_screens/newgroup_screen.dart';
import 'package:polimer/features/signin/precentation/screens/signin_screen.dart';
import 'package:polimer/models/chat_list_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color.fromARGB(255, 255, 111, 0),
        title: Text(
          "POLIMER",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
          myPopupMenuButton(),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.email!.split("@").first)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List snapshotdata = snapshot.data["chatlist"];

              if (snapshotdata.isNotEmpty) {
                final mychatlist = ChatList.fromJson(snapshot.data!.data()!);
                return ListView.builder(
                    itemCount: mychatlist.chatlist.length,
                    itemBuilder: (context, index) {
                      final userdata = mychatlist.chatlist[index];
                      return userTile(userdata.name, userdata.image,
                          userdata.db, "where are you", context);
                    });
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: Text("no users"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewchatScreen()));
        },
        backgroundColor: Color.fromARGB(255, 255, 111, 0),
        child: Icon(Icons.message),
      ),
    );
  }
}
