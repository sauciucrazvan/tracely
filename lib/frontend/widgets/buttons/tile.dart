import 'package:flutter/material.dart';

Widget tile(
    BuildContext context, String title, Widget leading, Function()? onTap) {
  return ListTile(
    tileColor: Theme.of(context).colorScheme.secondary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
        fontSize: 16,
      ),
    ),
    titleAlignment: ListTileTitleAlignment.center,
    leading: leading,
    onTap: onTap,
  );
}
