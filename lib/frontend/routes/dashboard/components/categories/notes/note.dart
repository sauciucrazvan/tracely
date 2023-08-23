import 'package:flutter/material.dart';

class NoteWidget extends StatefulWidget {
  final int index;

  const NoteWidget({super.key, required this.index});

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
                    "Note #${widget.index + 1}",
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
                        "08:00 11/09/2001",
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
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: Colors.lightBlue),
                        ),
                        IconButton(
                          onPressed: () {},
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
