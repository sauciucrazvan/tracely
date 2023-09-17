import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/backend/domains/expenses/expenses_manipulator.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Lottie.asset(
                "assets/animations/chart.json",
                width: 64,
                height: 64,
              ),
            ],
          ),
          numberOfNotes(context),
          numberOfChecklists(context),
          numberOfExpenses(context),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}
