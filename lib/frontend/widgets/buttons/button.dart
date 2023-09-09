import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final IconData icon;
  final Function? pressed;
  final Color color;

  const SmallButton(
      {super.key, required this.icon, this.pressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pressed!(),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
