import 'package:flutter/material.dart';

import 'package:tracely/frontend/widgets/buttons/button.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final Function? confirm;

  const ConfirmDialog({super.key, required this.title, this.confirm});

  @override
  Widget build(BuildContext context) {
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
        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SmallButton(
          icon: Icons.done,
          pressed: confirm,
          color: Colors.lightGreen.shade800,
        ),
        SmallButton(
          icon: Icons.close,
          pressed: () => Navigator.pop(context),
          color: Colors.red.shade800,
        ),
      ],
    );
  }
}
