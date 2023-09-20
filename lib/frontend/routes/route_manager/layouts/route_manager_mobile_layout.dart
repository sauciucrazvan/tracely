import 'package:flutter/material.dart';
import 'package:tracely/frontend/routes/route_manager/layouts/sub_pages/expenses.dart';

import 'package:tracely/frontend/routes/route_manager/layouts/sub_pages/agenda.dart';
import 'package:tracely/frontend/routes/route_manager/layouts/sub_pages/home/home.dart';

import 'package:tracely/frontend/routes/route_manager/layouts/sub_pages/notes.dart';

import '../../../config/messages.dart';
import '../../../widgets/marginals/header.dart';

class RouteManagerMobileLayout extends StatefulWidget {
  const RouteManagerMobileLayout({super.key});

  @override
  State<RouteManagerMobileLayout> createState() =>
      _RouteManagerMobileLayoutState();
}

class _RouteManagerMobileLayoutState extends State<RouteManagerMobileLayout> {
  int _selectedIndex = 2;

  PageController pageController = PageController(initialPage: 2);

  final pages = [
    const Placeholder(),
    const NotesDashboard(),
    const Home(),
    const AgendaDashboard(),
    const ExpensesDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Image.asset(
          "assets/logo.png",
          height: 32,
          width: 32,
        ),
        backgroundColor,
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
            icon: Icon(Icons.list),
            label: goals,
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note),
            label: notes,
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: dashboard,
          ),
          NavigationDestination(
            icon: Icon(Icons.event),
            label: todo,
          ),
          NavigationDestination(
            icon: Icon(Icons.wallet),
            label: expenses,
          ),
        ],
        onDestinationSelected: (index) => setState(() {
          _selectedIndex = index;
          pageController.animateToPage(
            _selectedIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate,
          );
        }),
      ),
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
