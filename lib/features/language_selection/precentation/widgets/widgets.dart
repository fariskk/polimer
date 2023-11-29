import 'package:flutter/material.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';

languageSelectorWidget(BuildContext context) {
  return Center(
    child: GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.pink),
              child: LanguagePickerDialog(
                  titlePadding: EdgeInsets.all(8.0),
                  searchCursorColor: Colors.pinkAccent,
                  searchInputDecoration: InputDecoration(hintText: 'Search...'),
                  isSearchable: true,
                  title: Text('Select your language'),
                  onValuePicked: (Language language) {
                    print(language.name);
                  },
                  itemBuilder: buildDialogItem)),
        );
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(
                color: const Color.fromARGB(255, 255, 111, 0), width: 1.8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text("language"),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    ),
  );
}

Widget buildDialogItem(Language language) => Row(
      children: <Widget>[
        Text(language.name),
        SizedBox(width: 8.0),
        Flexible(child: Text("(${language.isoCode})"))
      ],
    );
