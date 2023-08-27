import 'package:flutter/material.dart';

import '../../../../config/messages.dart';
import '../../../checklists/add_checklist.dart';
import '../../components/titlebar.dart';

class AgendaDashboard extends StatelessWidget {
  const AgendaDashboard({super.key});

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

          // const Expanded(
          //   child: SingleChildScrollView(
          //     child: BuildAgenda(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
