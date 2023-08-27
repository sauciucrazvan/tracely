import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../backend/domains/checklists/checklist_manipulator.dart';
import '../../../../../backend/domains/notes/notes_manipulator.dart';

import '../../../../config/messages.dart';

Widget showStatistics(BuildContext context) {
  Color textColor = Theme.of(context).colorScheme.tertiary;
  Color secondaryColor = Theme.of(context).colorScheme.secondary;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: secondaryColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stats,
                style: GoogleFonts.roboto(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 4,
              ),
              numberOfNotes(context),
              numberOfChecklists(context),
            ],
          ),
          Lottie.asset(
            "assets/animations/chart.json",
            width: 64,
            height: 64,
          ),
        ],
      ),
    ),
  );
}
