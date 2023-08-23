import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/notes/edit/layouts/edit_notes_desktop_layout.dart';
import 'package:tracely/frontend/routes/notes/edit/layouts/edit_notes_mobile_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class EditNotes extends StatefulWidget {
  final String id;
  final Map data;
  const EditNotes({super.key, required this.id, required this.data});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: EditNotesMobileLayout(
        id: widget.id,
        data: widget.data,
      ),
      desktopBody: EditNotesDesktopLayout(
        id: widget.id,
        data: widget.data,
      ),
    );
  }
}
