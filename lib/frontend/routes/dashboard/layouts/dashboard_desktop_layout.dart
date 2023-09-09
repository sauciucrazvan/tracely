import 'package:flutter/material.dart';

import 'package:tracely/frontend/widgets/buttons/rounded_button.dart';

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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Image.asset(
          "assets/logo.png",
          height: 32,
          width: 32,
        ),
        centerTitle: true,
        backgroundColor: secondaryColor,
        shadowColor: Colors.transparent,
        actions: [
          Row(
            children: [
              RoundedButton(
                foregroundColor: Theme.of(context).colorScheme.background,
                backgroundColor: _selectedIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
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
                backgroundColor: _selectedIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
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
                backgroundColor: _selectedIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
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
                backgroundColor: _selectedIndex == 3
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
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
        ],
      ),
      body: pages[_selectedIndex],
    );
  }
}
