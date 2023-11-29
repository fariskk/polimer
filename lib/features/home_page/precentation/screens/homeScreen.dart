import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polimer/features/home_page/precentation/widgets/homeScreen_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    ),
                    PopupMenuItem(
                      child: Text("New Chat"),
                    ),
                    PopupMenuItem(
                      child: Text("New Group"),
                    ),
                    PopupMenuItem(
                      child: Text("Logout"),
                    ),
                  ])
        ],
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return userTile("faris kk", "", "where are you");
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 255, 111, 0),
        child: Icon(Icons.message),
      ),
    );
  }
}
