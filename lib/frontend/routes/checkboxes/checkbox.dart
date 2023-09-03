import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../frontend/routes/checkboxes/edit/edit_checkbox.dart';
import '../../../backend/functions/limit_string.dart';
import '../../../backend/domains/checkboxes/checkbox_manipulator.dart';

import '../../config/messages.dart';
import '../../config/palette.dart';
import '../../widgets/dialogs/dialog.dart';

class CheckboxWidget extends StatelessWidget {
  final String categoryID;
  final String checkboxID;
  final String categoryName;
  final String categoryColor;
  final String title;
  final String date;
  final bool checked;

  const CheckboxWidget({
    super.key,
    required this.categoryName,
    required this.categoryColor,
    required this.title,
    required this.date,
    required this.checked,
    required this.categoryID,
    required this.checkboxID,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            icon: checked ? Icons.check_box : Icons.check_box_outline_blank,
            onPressed: (context) =>
                markCheckbox(categoryID, checkboxID, !checked),
          ),
          SlidableAction(
            backgroundColor: Colors.lightGreen.shade800,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            icon: Icons.edit,
            onPressed: (context) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditCheckbox(
                  categoryID: categoryID,
                  checkboxID: checkboxID,
                  name: title,
                  date: date,
                ),
              ),
            ),
          ),
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            icon: Icons.delete,
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => alertDialog(
                context,
                removeCheckbox,
                () {
                  deleteCheckbox(categoryID, checkboxID);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onLongPress: () => markCheckbox(categoryID, checkboxID, !checked),
        child: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (checked)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: colors[categoryColor],
                          ),
                        ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            decoration: checked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: colors[categoryColor],
                            decorationThickness: 2.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: textColor,
                        ),
                      ),
                      Text(
                        DateFormat("MMM d, yyyy").format(
                          DateTime.parse(
                            date,
                          ),
                        ),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: colors[categoryColor],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          limitString(categoryName, 32),
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
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
