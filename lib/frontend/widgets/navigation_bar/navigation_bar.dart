import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tracely/frontend/routes/dashboard/dashboard.dart';
import 'package:tracely/frontend/routes/loading/loading.dart';
import 'package:tracely/frontend/routes/notes/dashboard_notes.dart';

import '../../config/messages.dart';

class NavigationPanel extends StatefulWidget {
  final int index;

  const NavigationPanel({super.key, required this.index});

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  int _selectedIndex = 0;

  final pages = [
    const Dashboard(),
    const NotesDashboard(),
    const Loading(),
  ];

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.index;
    return NavigationBar(
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
      onDestinationSelected: (index) {
        setState(
          () => _selectedIndex = index,
        );

        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: pages[_selectedIndex],
          ),
        );
      },
    );
  }
}
