import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tracely/backend/handlers/routes/notes/notes_routes.dart';
import 'package:tracely/backend/handlers/routes/reminders/reminders_routes.dart';
import 'package:tracely/frontend/routes/dashboard/components/categories/notes/notes.dart';

import 'package:tracely/frontend/routes/dashboard/components/categories/reminders.dart';

import '../../../config/messages.dart';

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
                        // REMINDERS
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    titleBar(
                                      context,
                                      reminders,
                                      remindersRoute,
                                      () => showAddRemindersRoute(context),
                                    ),
                                    buildReminders(
                                      context,
                                      horizontal: false,
                                      countPerLine: 3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                              const Expanded(child: BuildNotes()),
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
