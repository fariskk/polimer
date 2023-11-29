import 'package:flutter/material.dart';
import 'package:polimer/features/new_chat/precentation/widgets/newchat_widgets.dart';
import 'package:polimer/features/new_group/precentation/newgroup_screens/newgroup_screen.dart';

class NewchatScreen extends StatelessWidget {
  const NewchatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewgroupScreen()));
              },
              leading: Icon(Icons.add),
              title: Text(
                "Create New Group",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter user name here",
                    hintStyle: TextStyle(fontSize: 18)),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "REACENT SEARCHS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))),
            recentsearchs(["fariskk", "fasl kk", "farhana kk"]),
          ],
        ),
      ),
    );
  }
}
