import 'package:flutter/material.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:polimer/features/language_selection/precentation/widgets/widgets.dart';

class LanguageSelectionScreen extends StatefulWidget {
  LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
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
      body: Stack(children: [
        Opacity(
          opacity: 0.1,
          child: Center(
            child: Icon(
              Icons.flutter_dash,
              size: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        languageSelectorWidget(context)
      ]),
    );
  }
}

class _selectedDialogLanguage {}
