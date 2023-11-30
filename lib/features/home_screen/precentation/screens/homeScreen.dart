import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polimer/features/account_screen/precentation/screens/account_screen.dart';
import 'package:polimer/features/home_screen/precentation/widgets/homeScreen_widgets.dart';

import 'package:polimer/features/new_chat/precentation/screens/newchat_screen.dart';

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
          PopupMenuButton(
              iconColor: Colors.white,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Account"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountScreen()));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("New Chat"),
                    ),
                    PopupMenuItem(
                      child: Text("New Group"),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text("Logout"),
                    ),
                  ])
        ],
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return userTile("faris kk",
            FirebaseAuth.instance.currentUser!.photoURL ?? "", "where are you");
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
