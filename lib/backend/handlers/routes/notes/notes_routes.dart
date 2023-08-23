import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/notes/add/add_notes.dart';
import 'package:tracely/frontend/routes/notes/edit/edit_notes.dart';
import 'package:tracely/frontend/routes/notes/view/view_notes.dart';

showAddNotesRoute(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNotes(),
      ),
    );

showEditNotesRoute(BuildContext context, String id, Map data) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotes(id: id, data: data),
      ),
    );

showViewNotesRoute(BuildContext context, Map data) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewNotes(data: data),
      ),
    );
