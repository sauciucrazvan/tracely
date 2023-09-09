import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/frontend/widgets/dialogs/dialog.dart';

import '../../../../backend/handlers/users/account_handler.dart';
import '../../../config/messages.dart';
import '../../../widgets/buttons/rounded_button.dart';

Widget topBar(BuildContext context) {
  Color textColor = Theme.of(context).colorScheme.tertiary;

  // Displays a different message everyday
  int index = DateTime.now().day.toInt() % welcome.length;

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  welcome.elementAt(
                    index,
                  ),
                  style: GoogleFonts.arimo(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "${getName()} 👋",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        roundedButton(
          Theme.of(context).colorScheme.background,
          Theme.of(context).colorScheme.primary,
          Icon(
            Icons.logout,
            color: textColor,
          ),
          () => showDialog(
            context: context,
            builder: (context) => ConfirmDialog(
              title: logout,
              confirm: () {
                signOutUser();
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    ),
  );
}
