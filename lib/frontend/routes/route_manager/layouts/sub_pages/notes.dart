import 'package:flutter/material.dart';

import '../../../../config/messages.dart';

import '../../../notes/add/add_notes.dart';
import '../../../notes/notes.dart';
import '../../components/titlebar.dart';

class NotesDashboard extends StatelessWidget {
  const NotesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),

          // NOTES
          titleBar(
            context,
            notes,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNotes(),
              ),
            ),
          ),

          const Expanded(
            child: SingleChildScrollView(
              child: BuildNotes(),
            ),
          ),
        ],
      ),
    );
  }
}
