import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/dashboard/layouts/mobile_pages/home.dart';
import 'package:tracely/frontend/routes/loading/loading.dart';

import 'package:tracely/frontend/routes/dashboard/layouts/mobile_pages/notes.dart';

import '../../../config/messages.dart';
import '../../../widgets/header/header.dart';

class DashboardMobileLayout extends StatefulWidget {
  const DashboardMobileLayout({super.key});

  @override
  State<DashboardMobileLayout> createState() => _DashboardMobileLayoutState();
}

class _DashboardMobileLayoutState extends State<DashboardMobileLayout> {
  int _selectedIndex = 0;

  final pages = [
    const Home(),
    const NotesDashboard(),
    const Loading(),
  ];

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
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        indicatorColor: Theme.of(context).colorScheme.primary,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: dashboard,
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note),
            label: notes,
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist),
            label: todo,
          ),
        ],
        onDestinationSelected: (index) => setState(
          () => _selectedIndex = index,
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
