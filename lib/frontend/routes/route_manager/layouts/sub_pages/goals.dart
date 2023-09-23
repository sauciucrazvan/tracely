import 'package:flutter/material.dart';
import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/routes/goals/add/add_goal.dart';
import 'package:tracely/frontend/routes/goals/goals.dart';
import 'package:tracely/frontend/routes/route_manager/components/titlebar.dart';

class GoalsDashboard extends StatelessWidget {
  const GoalsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        const SizedBox(
          height: 8,
        ),

        // NOTES
        titleBar(
          context,
          goals,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddGoal(),
            ),
          ),
        ),

        const Expanded(
          child: SingleChildScrollView(
            child: BuildGoals(),
          ),
        ),
      ],
    ));
  }
}
