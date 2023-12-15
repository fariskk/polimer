import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polimer/features/new_group/bloc/newgroup_bloc_bloc.dart';

Widget groupMembers(
    List groupmembers, List selectedMembers, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 100,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: groupmembers.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    groupmembers[index]["profileimage"])),
            title: Text(groupmembers[index]["username"]),
            trailing: TextButton(
              child: Text("Add"),
              onPressed: () {
                selectedMembers.add(groupmembers[index]);
                context
                    .read<NewgroupBlocBloc>()
                    .add(SerchCancelButtonClickedEvent());
              },
            ),
          );
        },
      ),
    ),
  );
}
