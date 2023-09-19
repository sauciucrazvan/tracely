import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tracely/backend/domains/notes/notes_manipulator.dart';
import 'package:tracely/frontend/widgets/dialogs/dialog.dart';

import '../../../backend/functions/limit_string.dart';
import '../../config/messages.dart';
import 'edit/edit_notes.dart';
import 'view/view_notes.dart';

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
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    String title = (widget.data['useEncryption']
        ? decryptNoteText(widget.data['title'], widget.data['iv'])
        : widget.data['title']);

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
                    limitString(title, 40),
                    style: Theme.of(context).textTheme.bodyMedium,
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
                        DateFormat("MMM d, yyyy | HH:mm").format(
                          DateTime.parse(
                            widget.data['last_edit'],
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  if (opened) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewNotes(data: widget.data),
                            ),
                          ),
                          icon: const Icon(Icons.visibility,
                              color: Colors.lightGreen),
                        ),
                        IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditNotes(id: widget.id, data: widget.data),
                            ),
                          ),
                          icon: const Icon(Icons.edit, color: Colors.lightBlue),
                        ),
                        IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => ConfirmDialog(
                              title: removeNote,
                              confirm: () {
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
