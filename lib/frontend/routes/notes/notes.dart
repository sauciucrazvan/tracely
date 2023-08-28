import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:tracely/backend/handlers/users/account_handler.dart';
import 'package:tracely/frontend/config/messages.dart';

import 'note.dart';

class BuildNotes extends StatelessWidget {
  const BuildNotes({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    return StreamBuilder(
      stream:
          database.child("users/${getUID()}/notes").onValue.asBroadcastStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Lottie.asset(
              "assets/animations/magic.json",
              width: 128,
              height: 128,
            ),
          );
        }

        if (snapshot.data?.snapshot.value != null &&
            snapshot.data?.snapshot.value is Map) {
          final notes = snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

          final notesList = notes.entries.toList();

          // Sorting the notes
          notesList.sort((a, b) {
            final DateTime lastEditA = DateTime.parse(a.value['last_edit']);
            final DateTime lastEditB = DateTime.parse(b.value['last_edit']);
            return lastEditB.compareTo(lastEditA);
          });

          return Column(
            children: notesList
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: NoteWidget(id: entry.key, data: entry.value),
                  ),
                )
                .toList(),
          );
        }

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/error.json",
                width: 256,
                height: 256,
              ),
              Text(
                noNotesSaved,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
