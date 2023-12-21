import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polimer/features/profilepicture_selection/precentation/screens/profilepicture_selection.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 255, 111, 0),
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              FirebaseAuth.instance.currentUser!.photoURL!)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!
                          .split("@")
                          .first,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
            leading: Icon(Icons.logout),
            title: Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
