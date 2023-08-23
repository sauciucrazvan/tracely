import 'package:flutter/material.dart';

ElevatedButton roundedButton(
  Color foregroundColor,
  Color backgroundColor,
  Widget child,
  Function()? onPressed,
) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(16),
    ),
    child: child,
  );
}
