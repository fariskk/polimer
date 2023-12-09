import 'package:flutter/widgets.dart';

Widget myMessage(String message, String time) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100),
      padding: EdgeInsets.only(top: 6, left: 5, right: 10, bottom: 0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 168, 108),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(message, style: TextStyle(fontSize: 17)),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 11),
          )
        ],
      ),
    ),
  );
}

Widget otherPersonMessage(String message, String time) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, right: 100, left: 5),
      padding: EdgeInsets.only(top: 6, left: 10, right: 5, bottom: 8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 168, 108),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(message, style: TextStyle(fontSize: 17)),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 11),
          )
        ],
      ),
    ),
  );
}
