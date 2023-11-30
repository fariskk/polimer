import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimer/features/home_screen/precentation/screens/homeScreen.dart';
import 'package:polimer/features/profilepicture_selection/bloc/profilepicture_bloc_bloc.dart';
import 'package:polimer/features/profilepicture_selection/precentation/widgets/profilepicture_selection_widgets.dart';

class ProfilepictureSlectionScreen extends StatelessWidget {
  ProfilepictureSlectionScreen(
      {super.key, required this.floatinactionButtonOnpressed});
  Function floatinactionButtonOnpressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser!.photoURL != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          }
        },
        backgroundColor: Color.fromARGB(255, 255, 111, 0),
        shape: const CircleBorder(),
        child: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: floatinactionButtonOnpressed(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Set a Profile Image",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<ProfilepictureBlocBloc, ProfilepictureBlocState>(
              builder: (context, state) {
                if (state is LoadedState) {
                  return CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 2.5 + 5,
                    backgroundColor: Color.fromARGB(255, 255, 111, 0),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 2.5,
                      backgroundImage: NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL!),
                    ),
                  );
                }
                if (state is Loadingstate) {
                  return CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 2.5 + 5,
                    backgroundColor: Color.fromARGB(255, 255, 111, 0),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 2.5,
                      backgroundImage:
                          AssetImage("assets/images/tempprofile.webp"),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                return CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 2.5 + 5,
                  backgroundColor: Color.fromARGB(255, 255, 111, 0),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 2.5,
                    backgroundImage:
                        AssetImage("assets/images/tempprofile.webp"),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileSelectionButton(Icons.camera_alt, () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    context
                        .read<ProfilepictureBlocBloc>()
                        .add(ImageSelectedevent(image.path));
                  }
                }),
                SizedBox(
                  width: 50,
                ),
                profileSelectionButton(Icons.image, () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    context
                        .read<ProfilepictureBlocBloc>()
                        .add(ImageSelectedevent(image.path));
                  }
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
