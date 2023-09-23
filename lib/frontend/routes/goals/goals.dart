import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:tracely/backend/domains/goals/goals_manipulator.dart';
import 'package:tracely/backend/functions/decrypt.dart';
import 'package:tracely/frontend/routes/goals/goal.dart';

import '../../config/messages.dart';

class BuildGoals extends StatelessWidget {
  const BuildGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getGoalsStream(),
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
          final goals = snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

          final goalsList = goals.entries.toList();

          // Sorting checkboxes by normal deadline
          goalsList.sort((a, b) {
            final DateTime lastEditA = DateTime.parse(a.value['deadline']);
            final DateTime lastEditB = DateTime.parse(b.value['deadline']);
            return lastEditA.compareTo(lastEditB);
          });

          // Sorting checkboxes by passed deadline
          goalsList.sort((a, b) {
            final String lastEditA = DateTime.parse(a.value['deadline'])
                .isBefore(DateTime.now())
                .toString();
            final String lastEditB = DateTime.parse(b.value['deadline'])
                .isBefore(DateTime.now())
                .toString();
            return lastEditA.compareTo(lastEditB);
          });

          // Sorting checkboxes by progress
          goalsList.sort((a, b) {
            final double progressA =
                (a.value['progress'] / a.value['maxProgress']);
            final double progressB =
                (b.value['progress'] / b.value['maxProgress']);
            return progressA.compareTo(progressB);
          });

          return Column(
            children: goalsList.map(
              (entry) {
                String goal = entry.value['goal'];
                String details = entry.value['details'];
                goal = decryptText(goal, entry.value['iv']);
                details = decryptText(details, entry.value['iv']);

                return GoalWidget(
                  first: goalsList.first.key == entry.key,
                  last: goalsList.last.key == entry.key,
                  goalID: entry.key,
                  goal: goal,
                  details: details,
                  deadline: entry.value['deadline'],
                  progress: entry.value['progress'],
                  maxProgress: entry.value['maxProgress'],
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
                noGoalsSaved,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
