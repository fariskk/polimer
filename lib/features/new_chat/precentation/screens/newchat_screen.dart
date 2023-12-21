import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polimer/features/chat_screen/bloc/chat_bloc_bloc.dart';
import 'package:polimer/features/chat_screen/precentation/screens/chat_screen.dart';
import 'package:polimer/features/new_chat/bloc/newchat_bloc_bloc.dart';
import 'package:polimer/features/new_chat/precentation/widgets/newchat_widgets.dart';
import 'package:polimer/features/new_group/precentation/newgroup_screens/newgroup_screen.dart';

class NewchatScreen extends StatelessWidget {
  NewchatScreen({super.key});
  var recentSearchBox = Hive.box("recentSearchBox");
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewchatBlocBloc, NewchatBlocState>(
      listener: (context, state) async {
        Directory dir = await getApplicationDocumentsDirectory();
        if (state is StartChatSuccessState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        username: state.username,
                        db: state.db,
                        profileImage: state.profileImage,
                        dir: dir,
                      )));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewgroupScreen()));
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
                  controller: _searchController,
                  decoration: InputDecoration(
                      suffixIcon:
                          BlocBuilder<NewchatBlocBloc, NewchatBlocState>(
                        builder: (context, state) {
                          if (state is SerachSuccessState) {
                            return IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                _searchController.text = "";
                                context
                                    .read<NewchatBlocBloc>()
                                    .add(SerchCancelButtonClickedEvent());
                              },
                            );
                          }
                          return IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              context.read<NewchatBlocBloc>().add(
                                  SearchButtonClickedEvent(
                                      serachQueary: _searchController.text));
                              recentSearchBox.add(_searchController.text);
                            },
                          );
                        },
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Enter user name here",
                      hintStyle: TextStyle(fontSize: 18)),
                ),
              ),
              BlocBuilder<NewchatBlocBloc, NewchatBlocState>(
                builder: (context, state) {
                  if (state is! SerachSuccessState) {
                    return Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "REACENT SEARCHES",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )));
                  }
                  return SizedBox();
                },
              ),
              BlocBuilder<NewchatBlocBloc, NewchatBlocState>(
                builder: (context, state) {
                  if (state is SerachSuccessState) {
                    if (state.searchResult.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: Text(
                            "User Not Exist",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: state.searchResult.length,
                          itemBuilder: (context, Index) {
                            final userdata = state.searchResult[Index];
                            return serchResultTile(userdata["username"],
                                userdata["profileimage"], context);
                          }),
                    );
                  }
                  return recentsearchs(recentSearchBox);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
