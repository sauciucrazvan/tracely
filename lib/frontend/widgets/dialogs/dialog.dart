import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/frontend/widgets/buttons/button.dart';

AlertDialog alertDialog(
  BuildContext context,
  String title,
  Function()? confirmFunction,
) {
  Color textColor = Theme.of(context).colorScheme.tertiary;
  return AlertDialog(
    title: Center(
      child: Image.asset(
        "assets/logo.png",
        width: 32,
        height: 32,
      ),
    ),
    content: Text(
      title,
      style: GoogleFonts.arimo(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Theme.of(context).colorScheme.background,
    actionsAlignment: MainAxisAlignment.center,
    actions: [
      actionButton(
        context,
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icons.done,
        onPressed: confirmFunction,
      ),
      actionButton(
        context,
        backgroundColor: Colors.red,
        icon: Icons.close,
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}
