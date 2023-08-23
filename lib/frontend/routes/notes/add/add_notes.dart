import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/notes/add/layouts/add_notes_desktop_layout.dart';
import 'package:tracely/frontend/routes/notes/add/layouts/add_notes_mobile_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: AddNotesMobileLayout(),
      desktopBody: AddNotesDesktopLayout(),
    );
  }
}
