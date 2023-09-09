import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String title;
  final Widget leading;
  final Function? onTap;

  const Tile(
      {super.key, required this.title, required this.leading, this.onTap});

  @override
  Widget build(BuildContext context) {
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
      onTap: () => onTap!(),
    );
  }
}
