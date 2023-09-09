import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:tracely/frontend/widgets/buttons/button.dart';
import 'package:tracely/frontend/widgets/dialogs/dialog.dart';

import '../../../../backend/handlers/users/account_handler.dart';
import '../../../config/messages.dart';

Widget topBar(BuildContext context) {
  Color textColor = Theme.of(context).colorScheme.tertiary;

  // Displays a different message everyday
  int index = DateTime.now().day.toInt() % welcome.length;

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
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
        SmallButton(
          icon: Icons.logout,
          color: Theme.of(context).colorScheme.primary,
          pressed: () => showDialog(
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
