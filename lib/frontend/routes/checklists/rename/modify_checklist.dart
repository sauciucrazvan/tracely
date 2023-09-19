import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tracely/backend/domains/checklists/checklist_manipulator.dart';
import 'package:tracely/frontend/widgets/notifications/elevated_notification.dart';

import '../../../config/messages.dart';
import '../../../config/palette.dart';
import '../../../widgets/buttons/button.dart';

class ModifyChecklist extends StatefulWidget {
  final String id;
  final String name;
  final String color;

  const ModifyChecklist(
      {super.key, required this.id, required this.name, required this.color});

  @override
  State<ModifyChecklist> createState() => _ModifyChecklistState();
}

class _ModifyChecklistState extends State<ModifyChecklist> {
  TextEditingController titleController = TextEditingController();
  String selectedColor = "red";

  @override
  void initState() {
    titleController.text = widget.name;
    selectedColor = widget.color;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;
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
        height: 128,
        child: Column(
          children: [
            Text(
              rename,
              style: GoogleFonts.arimo(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownButton(
              value: selectedColor,
              items: colors.keys
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: CircleAvatar(
                        backgroundColor: colors[value],
                        radius: 8,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                });
              },
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
        SmallButton(
          color: Theme.of(context).colorScheme.primary,
          icon: Icons.done,
          pressed: () {
            if (titleController.text.isNotEmpty) {
              editChecklist(widget.id, titleController.text, selectedColor);
            } else {
              showElevatedNotification(
                  context, checklistWithoutName, Colors.red);
            }
            Navigator.pop(context);
          },
        ),
        SmallButton(
          color: Colors.red,
          icon: Icons.close,
          pressed: () {
            titleController.clear();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
