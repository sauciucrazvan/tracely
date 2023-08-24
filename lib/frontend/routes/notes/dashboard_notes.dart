import 'package:flutter/material.dart';

import 'package:tracely/backend/handlers/routes/notes/notes_routes.dart';
import 'package:tracely/frontend/widgets/navigation_bar/navigation_bar.dart';

import '../../config/messages.dart';
import '../../widgets/header/header.dart';

import '../dashboard/components/categories/notes/notes.dart';
import '../dashboard/components/titlebar.dart';

class NotesDashboard extends StatelessWidget {
  const NotesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            "assets/logo.png",
            height: 32,
            width: 32,
          ),
        ),
        secondaryColor,
        true,
      ),
      bottomNavigationBar: const NavigationPanel(index: 1),
      body: SafeArea(
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
      ),
    );
  }
}
