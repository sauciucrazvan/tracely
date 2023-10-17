import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tracely/backend/domains/checklists/checklist_manipulator.dart';
import 'package:tracely/frontend/routes/checkboxes/view/view_checkboxes.dart';
import 'package:tracely/frontend/routes/checklists/rename/modify_checklist.dart';

import '../../config/messages.dart';
import '../../config/palette.dart';
import '../../widgets/dialogs/dialog.dart';

class ChecklistWidget extends StatelessWidget {
  final String id;
  final String name;
  final String color;
  final int count;
  final bool pinned;

  const ChecklistWidget({
    super.key,
    required this.id,
    required this.name,
    required this.color,
    required this.count,
    required this.pinned,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    // EASTER EGGS
    DateTime currentDate = DateTime.now();

    bool isChristmas = (currentDate.day >= 25 &&
        currentDate.day <= 27 &&
        currentDate.month == 12);
    bool isNewYear = (currentDate.day == 1 && currentDate.month == 1);
    bool isHalloween = (currentDate.day == 31 && currentDate.month == 10);

    Widget specialIcon() {
      if (isChristmas &&
          (color == "green" ||
              color == "red" ||
              color == "lightgreen" ||
              color == "lime")) {
        return Icon(
          Icons.snowing,
          color: textColor,
          size: 16,
        );
      }
      if (isNewYear &&
          (color == "blue" || color == "lightblue" || color == "cyan")) {
        return Icon(
          Icons.celebration,
          color: textColor,
          size: 16,
        );
      }
      if (isHalloween && (color == "orange" || color == "amber")) {
        return Icon(
          Icons.bloodtype,
          color: textColor,
          size: 16,
        );
      }

      return Container();
    }

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 4),
          SlidableAction(
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            icon: pinned ? Icons.star : Icons.star_border,
            onPressed: (context) => markChecklistPinned(id, pinned),
          ),
          const SizedBox(width: 4),
          SlidableAction(
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.lightGreen.shade800,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => ModifyChecklist(
                id: id,
                name: name,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SlidableAction(
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => ConfirmDialog(
                title: removeChecklist,
                confirm: () {
                  deleteChecklist(id);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewCheckboxes(
                id: id,
                name: name,
                color: color,
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: colors[color],
                    child: specialIcon(),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      "$count ${(count == 1) ? checkboxesCountSingular : checkboxesCountPlural}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  width: 64,
                  child: (pinned)
                      ? const Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                      : Icon(
                          Icons.keyboard_double_arrow_right_outlined,
                          color: textColor,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
