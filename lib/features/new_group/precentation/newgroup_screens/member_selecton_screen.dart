import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimer/features/new_group/bloc/newgroup_bloc_bloc.dart';
import 'package:polimer/features/new_group/precentation/newgroup_widgets/newgroup_widgets.dart';

class MemberSelectionScreen extends StatelessWidget {
  final _searchController = TextEditingController();
  MemberSelectionScreen(
      {super.key, required this.file, required this.groupNmae});
  List selectedMembers = [];
  String groupNmae;
  XFile file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  suffixIcon: BlocBuilder<NewgroupBlocBloc, NewgroupBlocState>(
                    builder: (context, state) {
                      if (state is SerachSuccessState) {
                        return IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            _searchController.text = "";
                            context
                                .read<NewgroupBlocBloc>()
                                .add(SerchCancelButtonClickedEvent());
                          },
                        );
                      }
                      return IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          context.read<NewgroupBlocBloc>().add(
                              SearchButtonClickedEvent(
                                  serachQueary: _searchController.text));
                        },
                      );
                    },
                  ),
                  border: OutlineInputBorder(),
                  hintText: "Enter user name here",
                  hintStyle: TextStyle(fontSize: 18)),
            ),
          ),
          BlocBuilder<NewgroupBlocBloc, NewgroupBlocState>(
            builder: (context, state) {
              if (state is SerachSuccessState) {
                if (state.searchResult.length == 0) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "User Not Exist",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                return groupMembers(
                    state.searchResult, selectedMembers, context);
              }
              return SizedBox();
            },
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "GROUP MEMBEERS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          BlocBuilder<NewgroupBlocBloc, NewgroupBlocState>(
            builder: (context, state) {
              return Expanded(
                  child: ListView.builder(
                      itemCount: selectedMembers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  selectedMembers[index]["profileimage"])),
                          title: Text(selectedMembers[index]["username"]),
                          trailing: TextButton(
                            child: Text("Remove"),
                            onPressed: () {
                              selectedMembers.removeAt(index);
                              context
                                  .read<NewgroupBlocBloc>()
                                  .add(SerchCancelButtonClickedEvent());
                            },
                          ),
                        );
                      }));
            },
          ),
          TextButton(
              onPressed: () {
                if (selectedMembers.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Pleace Select Members")));
                } else {
                  context.read<NewgroupBlocBloc>().add(
                      CreatGroupButtonClickedEvent(
                          members: selectedMembers,
                          imagepath: file.path,
                          name: groupNmae));
                }
              },
              child: Text("Create Group"))
        ],
      ),
    );
  }
}
