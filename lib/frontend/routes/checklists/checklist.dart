import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tracely/backend/domains/checklists/checklist_manipulator.dart';
import 'package:tracely/frontend/routes/checklists/rename/rename_checklist.dart';

import '../../config/messages.dart';
import '../../widgets/dialogs/dialog.dart';

class ChecklistWidget extends StatelessWidget {
  final String id;
  final String name;

  const ChecklistWidget({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

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
              builder: (context) => editChecklist(context, id, name),
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
                deleteChecklist,
                () {
                  removeChecklist(id);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
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
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_tab,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
