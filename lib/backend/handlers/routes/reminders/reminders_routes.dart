import 'package:flutter/material.dart';
import 'package:tracely/frontend/routes/add_reminders/add_reminders.dart';

showAddRemindersRoute(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => const AddReminders()));
