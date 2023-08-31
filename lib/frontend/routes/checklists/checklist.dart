import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tracely/backend/domains/checklists/checklist_manipulator.dart';
import 'package:tracely/frontend/routes/checkboxes/view/view_checkboxes.dart';
import 'package:tracely/frontend/routes/checklists/rename/modify_checklist.dart';

import '../../config/messages.dart';
import '../../widgets/dialogs/dialog.dart';

class ChecklistWidget extends StatelessWidget {
  final String id;
  final String name;
  final String color;
  final int count;

  const ChecklistWidget({
    super.key,
    required this.id,
    required this.name,
    required this.color,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
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
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
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
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => alertDialog(
                context,
                removeChecklist,
                () {
                  deleteChecklist(id);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
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
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: getColor(color),
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
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    "$count ${(count == 1) ? checkboxesCountSingular : checkboxesCountPlural}",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 64,
                child: Icon(
                  Icons.keyboard_tab,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
