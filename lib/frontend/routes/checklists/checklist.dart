import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tracely/backend/domains/checklists/checklist_manipulator.dart';

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
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: secondaryColor,
        trailing: Icon(
          Icons.arrow_back_ios,
          color: textColor,
        ),
        onTap: () {},
      ),
    );
  }
}
