import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

import 'layouts/add_reminders_desktop_layout.dart';
import 'layouts/add_reminders_mobile_layout.dart';

class AddReminders extends StatefulWidget {
  const AddReminders({super.key});

  @override
  State<AddReminders> createState() => _AddRemindersState();
}

class _AddRemindersState extends State<AddReminders> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: AddRemindersMobileLayout(),
      desktopBody: AddRemindersDesktopLayout(),
    );
  }
}
