import 'package:flutter/material.dart';

ElevatedButton roundedButton(
  Color foregroundColor,
  Color backgroundColor,
  Widget child,
  Function()? onPressed, {
  double size = 16,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      shape: const CircleBorder(),
      padding: EdgeInsets.all(size),
      minimumSize: Size(size * 2, size * 2),
    ),
    child: child,
  );
}
