import 'package:flutter/material.dart';

Widget recentsearchs(List recentSearchs) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: recentSearchs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(recentSearchs[index]),
          );
        },
      ),
    ),
  );
}
