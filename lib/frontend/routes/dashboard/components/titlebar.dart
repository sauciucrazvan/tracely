import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

Widget titleBar(
  BuildContext context,
  String title,
  String route,
  Function()? onPressed,
) {
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
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            alignment: Alignment.center,
          ),
          child: Text(
            "Add $route",
            style: TextStyle(color: textColor),
          ),
        ),
        const Divider(),
      ],
    ),
  );
}
