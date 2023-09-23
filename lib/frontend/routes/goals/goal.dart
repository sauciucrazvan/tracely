import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tracely/backend/domains/goals/goals_manipulator.dart';
import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/widgets/dialogs/dialog.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TimelineTile(
        isFirst: first,
        isLast: last,
        indicatorStyle: IndicatorStyle(
          color: (progress == maxProgress)
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
          iconStyle: (progress == maxProgress)
              ? IconStyle(iconData: Icons.done, color: Colors.white)
              : null,
        ),
        beforeLineStyle: LineStyle(
          color: (progress == maxProgress)
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
        afterLineStyle: LineStyle(
          color: (progress == maxProgress)
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.15,
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
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.keyboard_double_arrow_left_outlined,
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 4),
                      Text(goal, style: Theme.of(context).textTheme.bodyMedium),
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
    );
  }
}
