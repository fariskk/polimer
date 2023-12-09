import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polimer/features/account_screen/precentation/screens/account_screen.dart';
import 'package:polimer/features/chat_screen/precentation/screens/chat_screen.dart';
import 'package:polimer/features/new_chat/precentation/screens/newchat_screen.dart';
import 'package:polimer/features/new_group/precentation/newgroup_screens/newgroup_screen.dart';
import 'package:polimer/features/signin/precentation/screens/signin_screen.dart';

Widget userTile(String name, String image, String db, String lastMessage,
    BuildContext context) {
  return ListTile(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    username: name,
                    db: db,
                    profileImage: image,
                  )));
    },
    isThreeLine: true,
    title: Text(
      name,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
    subtitle: Text(lastMessage),
    leading: Container(
      width: 54,
      padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        color: Color.fromARGB(255, 241, 122, 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    ),
  );
}

Widget myPopupMenuButton() {
  return PopupMenuButton(
      iconColor: Colors.white,
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Account"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountScreen()));
              },
            ),
            PopupMenuItem(
              child: Text("New Chat"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewchatScreen()));
              },
            ),
            PopupMenuItem(
              child: Text("New Group"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewgroupScreen()));
              },
            ),
            PopupMenuItem(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: Text("Are you sure you want to Logout"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SigninScreen()),
                                    (route) => false);
                              },
                              child: Text("OK"))
                        ],
                      );
                    });
              },
              child: Text("Logout"),
            ),
          ]);
}
