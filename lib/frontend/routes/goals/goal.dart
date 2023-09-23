import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tracely/backend/functions/limit_string.dart';
import 'package:tracely/backend/domains/goals/goals_manipulator.dart';

import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/widgets/dialogs/dialog.dart';
import 'package:tracely/frontend/routes/goals/edit/edit_goal.dart';
import 'package:tracely/frontend/routes/goals/update/update_goal_progress.dart';

class GoalWidget extends StatelessWidget {
  final bool first;
  final bool last;
  final String goalID;
  final String goal;
  final String details;
  final String deadline;
  final int progress;
  final int maxProgress;

  const GoalWidget({
    super.key,
    required this.first,
    required this.last,
    required this.goalID,
    required this.goal,
    required this.details,
    required this.deadline,
    required this.progress,
    required this.maxProgress,
  });

  @override
  Widget build(BuildContext context) {
    Color timelineColor = (progress == maxProgress)
        ? Theme.of(context).colorScheme.primary
        : (DateTime.parse(deadline).isBefore(DateTime.now()))
            ? Colors.red
            : Colors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TimelineTile(
        isFirst: first,
        isLast: last,
        indicatorStyle: IndicatorStyle(
          width: 30,
          height: 30,
          color: timelineColor,
          iconStyle: (progress == maxProgress)
              ? IconStyle(iconData: Icons.done, color: Colors.white)
              : (DateTime.parse(deadline).isBefore(DateTime.now()))
                  ? IconStyle(iconData: Icons.error, color: Colors.white)
                  : IconStyle(iconData: Icons.timer, color: Colors.white),
        ),
        beforeLineStyle: LineStyle(
          color: timelineColor,
        ),
        afterLineStyle: LineStyle(
          color: timelineColor,
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.5,
              motion: const ScrollMotion(),
              children: [
                const SizedBox(width: 4),
                SlidableAction(
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  onPressed: (context) => showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                      title: removeGoal,
                      confirm: () {
                        deleteGoal(goalID);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SlidableAction(
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: Colors.lightGreen.shade700,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  onPressed: (context) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditGoal(
                        goalID: goalID,
                        goal: goal,
                        details: details,
                        deadline: deadline,
                        maxProgress: maxProgress,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => UpdateGoalProgress(
                    goalID: goalID,
                    goal: goal,
                    details: details,
                    progress: progress,
                    maxProgress: maxProgress,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.keyboard_double_arrow_left_outlined,
                        color: Theme.of(context).textTheme.bodyMedium!.color!,
                      ),
                      const SizedBox(width: 4),
                      Text(
                          limitString(
                              goal,
                              (MediaQuery.of(context).size.width > 1200
                                  ? 32
                                  : 12)),
                          style: Theme.of(context).textTheme.bodyMedium),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            DateFormat("MMM dd, yyyy").format(
                              DateTime.parse(deadline),
                            ),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("$progress / $maxProgress",
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 2),
                          SizedBox(
                            width: 100,
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(4),
                              value: (progress / maxProgress),
                              color: Theme.of(context).colorScheme.primary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
