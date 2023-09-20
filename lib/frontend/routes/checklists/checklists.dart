import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:tracely/backend/domains/checklists/checklist_manipulator.dart';
import 'package:tracely/backend/functions/decrypt.dart';

import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/routes/checklists/checklist.dart';

class BuildAgenda extends StatelessWidget {
  const BuildAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getChecklistsStream(),
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

          // Sorting checkboxes by entries
          checklistsList.sort((a, b) {
            final int lastEditA = (a.value['checkboxes'] as Map?)?.length ?? 0;
            final int lastEditB = (b.value['checkboxes'] as Map?)?.length ?? 0;
            return lastEditB.compareTo(lastEditA);
          });

          // Sorting checkboxes by value
          checklistsList.sort((a, b) {
            final bool lastEditA = a.value['pinned'] ?? false;
            final bool lastEditB = b.value['pinned'] ?? false;
            return lastEditB.toString().compareTo(lastEditA.toString());
          });

          return Column(
            children: checklistsList.map((entry) {
              String checklist = entry.value['title'];
              if (entry.value['iv'] == null) {
                encryptChecklist(entry.key, checklist);
                return const CircularProgressIndicator();
              }

              checklist = decryptText(checklist, entry.value['iv']);

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ChecklistWidget(
                  id: entry.key,
                  name: checklist,
                  color: entry.value['color'] ?? "red",
                  count: (entry.value['checkboxes'] as Map?)?.length ?? 0,
                  pinned: entry.value['pinned'] ?? false,
                ),
              );
            }).toList(),
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
