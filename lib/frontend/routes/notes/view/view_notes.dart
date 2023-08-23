import 'package:flutter/material.dart';
import 'package:tracely/frontend/routes/notes/view/layouts/view_notes_desktop_layout.dart';
import 'package:tracely/frontend/routes/notes/view/layouts/view_notes_mobile_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class ViewNotes extends StatefulWidget {
  final Map data;
  const ViewNotes({super.key, required this.data});

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: ViewNotesMobileLayout(
        data: widget.data,
      ),
      desktopBody: ViewNotesDesktopLayout(
        data: widget.data,
      ),
    );
  }
}
