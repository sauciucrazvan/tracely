import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/backend/handlers/routes/notes/notes_routes.dart';

import '../../../../backend/handlers/routes/reminders/reminders_routes.dart';
import '../../../config/messages.dart';
import '../../../widgets/header/header.dart';

import '../components/categories/notes/notes.dart';
import '../components/categories/reminders.dart';
import '../components/titlebar.dart';
import '../components/topbar.dart';

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Container(),
        secondaryColor,
        true,
        leading: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            dashboard,
            style: GoogleFonts.arimo(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        leadingWidth: 128,
        trailing: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/logo.png",
              height: 32,
              width: 32,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  topBar(context),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            // REMINDERS
            titleBar(
              context,
              reminders,
              remindersRoute,
              () => showAddRemindersRoute(context),
            ),

            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 128),
              child: buildReminders(context),
            ),

            // NOTES
            titleBar(
              context,
              notes,
              notesRoute,
              () => showAddNotesRoute(context),
            ),

            Expanded(child: buildNotes(context)),
          ],
        ),
      ),
    );
  }
}
