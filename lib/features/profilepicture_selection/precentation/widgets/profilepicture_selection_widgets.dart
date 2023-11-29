import 'package:flutter/material.dart';

Widget profileSelectionButton(IconData icon, Function onpressed) => IconButton(
    onPressed: () {
      onpressed();
    },
    icon: Icon(
      icon,
      size: 35,
    ));
