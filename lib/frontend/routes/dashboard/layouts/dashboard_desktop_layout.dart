import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tracely/backend/handlers/routes/notes/notes_routes.dart';
import 'package:tracely/frontend/routes/notes/notes.dart';

import '../../../config/messages.dart';

import '../../checklists/add/add_checklist.dart';
import '../../checklists/checklists.dart';
import '../components/titlebar.dart';
import '../components/topbar.dart';

class DashboardDesktopLayout extends StatefulWidget {
  const DashboardDesktopLayout({super.key});

  @override
  State<DashboardDesktopLayout> createState() => _DashboardDesktopLayoutState();
}

class _DashboardDesktopLayoutState extends State<DashboardDesktopLayout> {
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;

    int index = Random().nextInt(info.length);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            Drawer(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 64,
                      width: 64,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            info.elementAt(index),
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  topBar(context),
                  Divider(color: Theme.of(context).colorScheme.secondary),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              titleBar(
                                context,
                                todo,
                                todoRoute,
                                () => showDialog(
                                  context: context,
                                  builder: (context) => addChecklist(context),
                                ),
                              ),
                              const Expanded(
                                child: SingleChildScrollView(
                                  child: BuildAgenda(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
