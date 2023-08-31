import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../frontend/config/messages.dart';
import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertChecklist(String name, String color) async {
  String userId = getUID();

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  await database.child("users/$userId/checklists/$id").set({
    'title': name,
    'color': color,
  });
}

void editChecklist(String id, String name, String color) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").update({
    'title': name,
    'color': color,
  });
}

void deleteChecklist(String id) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").remove();
}

Color getColor(String color) {
  switch (color) {
    case "red":
      return Colors.red;
    case "blue":
      return Colors.blue;
    case "green":
      return Colors.green;
    case "yellow":
      return Colors.yellow;
    case "purple":
      return Colors.purple;
    case "pink":
      return Colors.pink;
    case "orange":
      return Colors.orange;
    case "cyan":
      return Colors.cyan;
    case "lime":
      return Colors.lime;
    case "amber":
      return Colors.amber;
    case "lightgreen":
      return Colors.lightGreen;
    case "lightblue":
      return Colors.lightBlue;
  }
  return Colors.white;
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
