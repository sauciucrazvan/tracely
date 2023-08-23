import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tracely/backend/domains/notes/notes_manipulator.dart';
import 'package:tracely/backend/handlers/routes/notes/notes_routes.dart';
import 'package:tracely/frontend/widgets/dialogs/dialog.dart';

import '../../../../../config/messages.dart';

class NoteWidget extends StatefulWidget {
  final String id;
  final Map data;

  const NoteWidget({super.key, required this.id, required this.data});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['title'],
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_sharp,
                        color: textColor,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        DateFormat("HH:mm dd/MM/yyyy").format(
                          DateTime.parse(
                            widget.data['last_edit'],
                          ),
                        ),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  if (opened) const SizedBox(height: 8),
                  if (opened)
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility,
                              color: Colors.lightGreen),
                        ),
                        IconButton(
                          onPressed: () => showEditNotesRoute(
                              context, widget.id, widget.data),
                          icon: const Icon(Icons.edit, color: Colors.lightBlue),
                        ),
                        IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => alertDialog(
                              context,
                              removeNote,
                              () {
                                deleteNote(widget.id);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () => setState(() => opened = !opened),
            icon: opened
                ? Icon(
                    Icons.keyboard_arrow_left,
                    color: textColor,
                  )
                : Icon(
                    Icons.keyboard_arrow_up,
                    color: textColor,
                  ),
          ),
        ],
      ),
    );
  }
}
