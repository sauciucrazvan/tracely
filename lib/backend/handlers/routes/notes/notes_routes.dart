import 'package:flutter/material.dart';
import 'package:tracely/frontend/routes/notes/add/add_notes.dart';

showAddNotesRoute(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNotes(),
      ),
    );
