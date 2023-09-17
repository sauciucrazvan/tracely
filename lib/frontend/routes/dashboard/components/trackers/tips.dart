import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/messages.dart';

Widget showTips(BuildContext context) {
  Color textColor = Theme.of(context).colorScheme.tertiary;
  Color secondaryColor = Theme.of(context).colorScheme.secondary;

  String tipsText = "";

  for (var tip in tipsList) {
    tipsText = "$tipsText$tip\n";
  }

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
                tips,
                style: GoogleFonts.roboto(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              Lottie.asset(
                "assets/animations/tips.json",
                width: 64,
                height: 64,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              tipsText,
              style: GoogleFonts.roboto(
                color: textColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}
