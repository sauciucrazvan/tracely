import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tracely/backend/handlers/users/account_handler.dart';
import 'package:tracely/frontend/config/messages.dart';

import 'note.dart';

DatabaseReference database = FirebaseDatabase.instance.ref();

class BuildNotes extends StatefulWidget {
  const BuildNotes({super.key});

  @override
  State<BuildNotes> createState() => _BuildNotesState();
}

class _BuildNotesState extends State<BuildNotes> {
  @override
  void initState() {
    FirebaseDatabase.instance.goOnline();

    super.initState();
  }

  @override
  void dispose() {
    FirebaseDatabase.instance.goOffline();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                "assets/animations/empty.json",
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
