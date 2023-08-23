import 'package:flutter/material.dart';

void showElevatedNotification(BuildContext context, String message, Color color,
    {Duration? duration}) {
  final snackBar = SnackBar(
    content: Center(
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      ),
    ),
    backgroundColor: color,
    shape: const StadiumBorder(),
    behavior: SnackBarBehavior.floating,
    duration: duration ?? const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
