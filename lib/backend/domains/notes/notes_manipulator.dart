import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/frontend/config/messages.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();
String userId = getUID();

/*

  FUNCTIONS

*/

void insertNote(String title, String content, bool useMarkdown) async {
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  await database.child("users/$userId/notes/$id").set({
    'title': title,
    'content': content,
    'useMarkdown': useMarkdown,
    'last_edit': DateTime.now().toString(),
  });
}

void editNote(String id, String title, String content, bool useMarkdown) async {
  await database.child("users/$userId/notes/$id").update({
    'title': title,
    'content': content,
    'useMarkdown': useMarkdown,
    'last_edit': DateTime.now().toString(),
  });
}

void deleteNote(String id) async =>
    await database.child("users/$userId/notes/$id").remove();

/*

  WIDGETS

*/

Widget numberOfNotes(BuildContext context) {
  return StreamBuilder(
    stream: database.child("users/$userId/notes").onValue.asBroadcastStream(),
    builder: (context, dataSnapshot) {
      int numberOfNotes = 0;

      if (dataSnapshot.hasData && dataSnapshot.data?.snapshot.value is Map) {
        Map<dynamic, dynamic> notesMap =
            dataSnapshot.data?.snapshot.value as Map;
        numberOfNotes = notesMap.length;
      }

      return Text(
        "$notesSaved $numberOfNotes",
        style: GoogleFonts.roboto(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 16,
          fontWeight: FontWeight.w100,
        ),
        textAlign: TextAlign.start,
      );
    },
  );
}
