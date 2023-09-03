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
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  tipsText,
                  style: GoogleFonts.roboto(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Lottie.asset(
            "assets/animations/tips.json",
            width: 64,
            height: 64,
          ),
        ],
      ),
    ),
  );
}
