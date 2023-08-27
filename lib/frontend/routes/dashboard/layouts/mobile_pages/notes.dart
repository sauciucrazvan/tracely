import 'package:flutter/material.dart';

import 'package:tracely/backend/handlers/routes/notes/notes_routes.dart';

import '../../../../config/messages.dart';

import '../../../notes/notes.dart';
import '../../components/titlebar.dart';

class NotesDashboard extends StatelessWidget {
  const NotesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),

          // NOTES
          titleBar(
            context,
            notes,
            notesRoute,
            () => showAddNotesRoute(context),
          ),

          const Expanded(
            child: SingleChildScrollView(
              child: BuildNotes(),
            ),
          ),
        ],
      ),
    );
  }
}
