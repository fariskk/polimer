import 'package:flutter/material.dart';

Widget userTile(String name, String image, String lastMessage) {
  return ListTile(
    isThreeLine: true,
    title: Text(
      name,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
    subtitle: Text(lastMessage),
    leading: CircleAvatar(
      radius: 28,
      child: Image.asset("assets/images/tempprofile.webp"),
    ),
  );
}
