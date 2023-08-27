import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../frontend/config/messages.dart';
import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertChecklist(String name) async {
  String userId = getUID();

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  await database.child("users/$userId/checklists/$id").set({
    'title': name,
  });
}

void renameChecklist(String id, String name) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").set({
    'title': name,
  });
}

void removeChecklist(String id) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").remove();
}

/*

  WIDGETS

*/

Widget numberOfChecklists(BuildContext context) {
  String userId = getUID();

  return StreamBuilder(
    stream:
        database.child("users/$userId/checklists").onValue.asBroadcastStream(),
    builder: (context, dataSnapshot) {
      int numberOfChecklists = 0;

      if (dataSnapshot.hasData && dataSnapshot.data?.snapshot.value is Map) {
        Map<dynamic, dynamic> notesMap =
            dataSnapshot.data?.snapshot.value as Map;
        numberOfChecklists = notesMap.length;
      }

      return Text(
        "$todoSaved $numberOfChecklists",
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
