import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:polimer/features/new_chat/bloc/newchat_bloc_bloc.dart';

Widget recentsearchs(Box recentSearchs) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: recentSearchs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(recentSearchs.getAt(index)),
                IconButton(
                    onPressed: () {
                      recentSearchs.deleteAt(index);
                      context
                          .read<NewchatBlocBloc>()
                          .add(SerchCancelButtonClickedEvent());
                    },
                    icon: Icon(
                      Icons.cancel,
                      size: 17,
                    ))
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget serchResultTile(String name, String imageUrl, BuildContext context) {
  return ListTile(
    title: Text(name),
    leading: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(45)),
        child: CachedNetworkImage(
          width: 40,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    ),
    trailing: TextButton(
        onPressed: () {
          String myName =
              FirebaseAuth.instance.currentUser!.email!.split("@").first;
          context.read<NewchatBlocBloc>().add(StartChatButtonClickedEvent(
              myDocId: myName, newPersonDocid: name));
        },
        child: Text(
          "Start Chat",
          style: TextStyle(fontSize: 12),
        )),
  );
}
