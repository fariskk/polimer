import 'package:flutter/widgets.dart';

Widget myMessage(String message) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 100),
        padding: EdgeInsets.only(top: 6, left: 10, right: 10, bottom: 8),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 111, 0),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12))),
        child: Column(
          children: [
            Text("helow mate tftf  ufufutf tftftfiutf ftuftyftyfi"),
            Align(
              alignment: Alignment.bottomRight,
              child: Text("10:55"),
            )
          ],
        )),
  );
}
