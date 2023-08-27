import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/frontend/widgets/notifications/elevated_notification.dart';

import '../../../../backend/domains/checklists/checklist_manipulator.dart';
import '../../../config/messages.dart';
import '../../../widgets/buttons/button.dart';

Widget editChecklist(BuildContext context, String id, String title) {
  TextEditingController titleController = TextEditingController();

  titleController.text = title; // DEFAULT VALUE

  Color textColor = Theme.of(context).colorScheme.tertiary;
  Color backgroundColor = Theme.of(context).colorScheme.background;
  Color secondaryColor = Theme.of(context).colorScheme.secondary;
  Color primaryColor = Theme.of(context).colorScheme.primary;

  return AlertDialog(
    title: Center(
      child: Image.asset(
        "assets/logo.png",
        width: 32,
        height: 32,
      ),
    ),
    content: SizedBox(
      width: 300,
      height: 70,
      child: Column(
        children: [
          Text(
            "$rename $todoRoute",
            style: GoogleFonts.arimo(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextField(
              controller: titleController,
              maxLength: 64,
              maxLines: 1,
              obscureText: false,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: secondaryColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                counterText: '',
              ),
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: backgroundColor,
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      actionButton(
        context,
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icons.done,
        onPressed: () {
          if (titleController.text.isNotEmpty) {
            renameChecklist(id, titleController.text);
          } else {
            showElevatedNotification(context, checklistWithoutName, Colors.red);
          }
          Navigator.pop(context);
        },
      ),
      actionButton(
        context,
        backgroundColor: Colors.red,
        icon: Icons.close,
        onPressed: () {
          titleController.clear();
          Navigator.pop(context);
        },
      ),
    ],
  );
}
