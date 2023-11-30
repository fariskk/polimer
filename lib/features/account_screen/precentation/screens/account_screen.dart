import 'package:flutter/material.dart';

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
                        backgroundImage:
                            AssetImage("assets/images/tempprofile.webp"),
                        radius: 30,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "faris kk",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {}, child: Text("Change Profile Image"))
              ],
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          ListTile(
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
