import 'package:flutter/material.dart';

ElevatedButton actionButton(BuildContext context,
    {Function()? onPressed,
    required Color backgroundColor,
    required IconData icon}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
    ),
    child: Icon(
      icon,
      color: Theme.of(context).colorScheme.tertiary,
    ),
  );
}
