import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimer/features/new_group/precentation/newgroup_screens/member_selecton_screen.dart';
import 'package:polimer/features/new_group/precentation/newgroup_widgets/newgroup_widgets.dart';

class NewgroupScreen extends StatelessWidget {
  NewgroupScreen({super.key});
  final _nameController = TextEditingController();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (image != null && _nameController.text != "") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MemberSelectionScreen(
                            file: image!,
                            groupNmae: _nameController.text,
                          )));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(image == null
                      ? "Please select a Profile image"
                      : "Enter a Group Name")));
            }
          },
          backgroundColor: const Color.fromARGB(255, 255, 111, 0),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          )),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter Group name here",
                    hintStyle: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                },
                child: Text("Select a Profile Image"))
          ],
        ),
      ),
    );
  }
}
