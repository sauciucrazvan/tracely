import 'package:flutter/material.dart';

import '../../../../frontend/routes/notes/notes.dart';
import '../../../../backend/handlers/routes/notes/notes_routes.dart';

import '../../../config/messages.dart';

import '../../../widgets/header/header.dart';

import '../../checklists/add/add_checklist.dart';
import '../../checklists/checklists.dart';

import '../components/titlebar.dart';
import '../components/topbar.dart';

import '../components/trackers/about.dart';
import '../components/trackers/statistics.dart';

class DashboardDesktopLayout extends StatefulWidget {
  const DashboardDesktopLayout({super.key});

  @override
  State<DashboardDesktopLayout> createState() => _DashboardDesktopLayoutState();
}

class _DashboardDesktopLayoutState extends State<DashboardDesktopLayout> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Image.asset(
          "assets/logo.png",
          height: 32,
          width: 32,
        ),
        secondaryColor,
        true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Displays the greetings message & sign out button
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
              height: 16,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Displays about
                showAbout(context),

                const SizedBox(
                  width: 16,
                ),

                // Displays statistics
                SizedBox(
                  width: 512,
                  child: showStatistics(context),
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),

            // Agenda
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      titleBar(
                        context,
                        todo,
                        () => showDialog(
                          context: context,
                          builder: (context) => const AddChecklist(),
                        ),
                      ),
                      const BuildAgenda(),
                    ],
                  ),
                ),

                // Expenses !!! REQUIRES MORE WORK. TO DO LATER
                // Expanded(
                //   child: Column(
                //     children: [
                //       titleBar(
                //         context,
                //         expenses,
                //         () => showDialog(
                //           context: context,
                //           builder: (context) => const AddExpense(),
                //         ),
                //       ),
                //       const BuildExpenses(),
                //     ],
                //   ),
                // ),

                // Notes
                Expanded(
                  child: Column(
                    children: [
                      titleBar(
                        context,
                        notes,
                        () => showAddNotesRoute(context),
                      ),
                      const BuildNotes(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
