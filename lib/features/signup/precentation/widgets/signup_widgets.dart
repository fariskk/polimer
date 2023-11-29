import 'package:flutter/material.dart';

Widget myTextfield(TextEditingController controller, String labelText) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.8,
            color: Color.fromARGB(255, 255, 111, 0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.8,
            color: Color.fromARGB(255, 255, 111, 0),
          ),
        ),
      ),
    ),
  );
}
