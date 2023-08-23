import 'package:flutter/material.dart';

import 'note.dart';

Widget buildNotes(BuildContext context) {
  return ListView.builder(
    itemCount: 15,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: NoteWidget(index: index),
      );
    },
  );
}
