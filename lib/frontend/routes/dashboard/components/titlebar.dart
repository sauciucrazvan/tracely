import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/frontend/widgets/buttons/rounded_button.dart';

Widget titleBar(
  BuildContext context,
  String title,
  Function()? onPressed, {
  double size = 12,
}) {
  Color textColor = Theme.of(context).colorScheme.tertiary;
  Color primaryColor = Theme.of(context).colorScheme.primary;

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: GoogleFonts.arimo(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const Spacer(),
        RoundedButton(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          onPressed: onPressed,
          size: size,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: size * 2,
          ),
        ),
        const Divider(),
      ],
    ),
  );
}
