import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimer/features/profilepicture_selection/precentation/widgets/profilepicture_selection_widgets.dart';

class ProfilepictureSlectionScreen extends StatelessWidget {
  const ProfilepictureSlectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromARGB(255, 255, 111, 0),
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Set a Profile Image",
              style: TextStyle(fontSize: 19),
            ),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 2.5,
              child: Image.asset("assets/images/tempprofile.webp"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileSelectionButton(Icons.camera_alt, () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                }),
                SizedBox(
                  width: 50,
                ),
                profileSelectionButton(Icons.image, () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
