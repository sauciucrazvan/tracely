import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tracely/frontend/routes/checklists/checklist.dart';

import '../../../backend/handlers/users/account_handler.dart';
import '../../config/messages.dart';

class BuildAgenda extends StatelessWidget {
  const BuildAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    return StreamBuilder(
      stream: database
          .child("users/${getUID()}/checklists")
          .onValue
          .asBroadcastStream(),
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
          final checklists =
              snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

          final checklistsList = checklists.entries.toList();

          return Column(
            children: checklistsList
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ChecklistWidget(
                      id: entry.key,
                      name: entry.value['title'],
                      color: entry.value['color'] ?? "red",
                      count: (entry.value['checkboxes'] != null
                          ? (entry.value['checkboxes']!
                                  as Map<dynamic, dynamic>)
                              .length
                          : 0),
                    ),
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
                noChecklistsSaved,
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