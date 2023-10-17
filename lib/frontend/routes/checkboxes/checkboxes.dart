import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tracely/backend/domains/checkboxes/checkbox_manipulator.dart';
import 'package:tracely/backend/functions/decrypt.dart';
import 'package:tracely/frontend/routes/checkboxes/checkbox.dart';

import '../../../backend/handlers/users/account_handler.dart';
import '../../config/messages.dart';

class BuildCheckboxes extends StatelessWidget {
  final String id;
  final String name;
  final String color;

  const BuildCheckboxes(
      {super.key, required this.id, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    DatabaseReference database = FirebaseDatabase.instance.ref();

    return StreamBuilder(
      stream: database
          .child("users/${getUID()}/checklists/$id/checkboxes")
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
          final checkboxes =
              snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

          final checkboxesList = checkboxes.entries.toList();

          // Sorting checkboxes by date
          checkboxesList.sort((a, b) {
            final DateTime lastEditA = DateTime.parse(a.value['date']);
            final DateTime lastEditB = DateTime.parse(b.value['date']);
            return lastEditA.compareTo(lastEditB);
          });

          // Sorting checkboxes by value
          checkboxesList.sort((a, b) {
            final bool lastEditA = a.value['checked'];
            final bool lastEditB = b.value['checked'];
            return lastEditA.toString().compareTo(lastEditB.toString());
          });

          return Column(
            children: checkboxesList.map(
              (entry) {
                String checkbox = entry.value['title'];
                if (entry.value['iv'] == null) {
                  encryptCheckbox(id, entry.key, checkbox);
                  return const CircularProgressIndicator();
                }

                checkbox = decryptText(checkbox, entry.value['iv']);

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CheckboxWidget(
                    categoryName: name,
                    categoryColor: color,
                    title: checkbox,
                    date: entry.value['date'],
                    checked: entry.value['checked'],
                    categoryID: id,
                    checkboxID: entry.key,
                  ),
                );
              },
            ).toList(),
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
                noCheckboxesSaved,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
