import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polimer/features/chat_screen/precentation/screens/chat_screen.dart';

Widget userTile(
    String name, String image, String lastMessage, BuildContext context) {
  return ListTile(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatScreen()));
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
          imageUrl: FirebaseAuth.instance.currentUser!.photoURL!,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    ),
  );
}
