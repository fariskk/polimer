import 'package:flutter/material.dart';

Widget groupMembers(List groupmembers) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: groupmembers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(groupmembers[index]),
          );
        },
      ),
    ),
  );
}
