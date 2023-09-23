import 'package:flutter/widgets.dart';
import 'package:tracely/frontend/routes/goals/edit/layouts/edit_goal_desktop_layout.dart';
import 'package:tracely/frontend/routes/goals/edit/layouts/edit_goal_mobile_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class EditGoal extends StatefulWidget {
  final String goalID;
  final String goal;
  final String details;
  final String deadline;
  final int maxProgress;

  const EditGoal({
    super.key,
    required this.goalID,
    required this.goal,
    required this.details,
    required this.deadline,
    required this.maxProgress,
  });

  @override
  State<EditGoal> createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: EditGoalMobileLayout(
        goalID: widget.goalID,
        goal: widget.goal,
        details: widget.details,
        deadline: widget.deadline,
        maxProgress: widget.maxProgress,
      ),
      desktopBody: EditGoalDesktopLayout(
        goalID: widget.goalID,
        goal: widget.goal,
        details: widget.details,
        deadline: widget.deadline,
        maxProgress: widget.maxProgress,
      ),
    );
  }
}
