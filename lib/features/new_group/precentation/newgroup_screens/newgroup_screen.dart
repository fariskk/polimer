import 'package:flutter/material.dart';
import 'package:polimer/features/new_group/precentation/newgroup_widgets/newgroup_widgets.dart';

class NewgroupScreen extends StatelessWidget {
  const NewgroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter user name here",
                    hintStyle: TextStyle(fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Group Name",
                    hintStyle: TextStyle(fontSize: 18)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "GROUP MEMBEERS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            groupMembers(["faris", "fasal", "farhana"]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: () {}, child: Text("Create Group")),
            )
          ],
        ),
      ),
    );
  }
}
