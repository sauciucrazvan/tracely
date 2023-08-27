import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/checklists/checklists.dart';

import '../../../../config/messages.dart';
import '../../../checklists/add/add_checklist.dart';
import '../../components/titlebar.dart';

class AgendaDashboard extends StatefulWidget {
  const AgendaDashboard({super.key});

  @override
  State<AgendaDashboard> createState() => _AgendaDashboardState();
}

class _AgendaDashboardState extends State<AgendaDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),

          // AGENDA
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
    );
  }
}
