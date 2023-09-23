import 'package:flutter/material.dart';

class GoalWidget extends StatelessWidget {
  final String goalID;
  final String goal;
  final String details;
  final String deadline;
  final int progress;
  final int maxProgress;

  const GoalWidget({
    super.key,
    required this.goalID,
    required this.goal,
    required this.details,
    required this.deadline,
    required this.progress,
    required this.maxProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
