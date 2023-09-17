import 'package:flutter/material.dart';
import 'package:tracely/backend/handlers/users/account_handler.dart';
import 'package:tracely/frontend/config/messages.dart';

import 'package:tracely/frontend/widgets/buttons/rounded_button.dart';
import 'package:tracely/frontend/widgets/dialogs/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sub_pages/agenda.dart';
import 'sub_pages/expenses.dart';
import 'sub_pages/home.dart';
import 'sub_pages/notes.dart';

class DashboardDesktopLayout extends StatefulWidget {
  const DashboardDesktopLayout({super.key});

  @override
  State<DashboardDesktopLayout> createState() => _DashboardDesktopLayoutState();
}

class _DashboardDesktopLayoutState extends State<DashboardDesktopLayout> {
  int _selectedIndex = 0;

  final pages = [
    const Home(),
    const NotesDashboard(),
    const AgendaDashboard(),
    const ExpensesDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor:
                  _selectedIndex == 0 ? primaryColor : secondaryColor,
              child: Icon(
                Icons.home,
                color: textColor,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            RoundedButton(
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor:
                  _selectedIndex == 1 ? primaryColor : secondaryColor,
              child: Icon(
                Icons.event_note,
                color: textColor,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            RoundedButton(
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor:
                  _selectedIndex == 2 ? primaryColor : secondaryColor,
              child: Icon(
                Icons.event,
                color: textColor,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            RoundedButton(
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor:
                  _selectedIndex == 3 ? primaryColor : secondaryColor,
              child: Icon(
                Icons.wallet,
                color: textColor,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            "assets/logo.png",
            height: 32,
            width: 32,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.tertiary,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmDialog(
                  title: logout,
                  confirm: () {
                    signOutUser();
                    Navigator.pop(context);
                  },
                ),
              ),
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomSheet: (_selectedIndex == 0)
          ? Container(
              color: secondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hey! What do you think about trying Tracely on Android?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              "https://github.com/sauciucrazvan/tracely/releases"));
                        },
                        child: Text(
                          "Download Tracely for Android",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
