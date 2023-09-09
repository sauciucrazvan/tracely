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
        Map<dynamic, dynamic> checklistsMap =
            dataSnapshot.data?.snapshot.value as Map;
        numberOfChecklists = checklistsMap.length;
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              todoSaved,
              style: GoogleFonts.roboto(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                Text(
                  numberOfChecklists.toString(),
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.event,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
