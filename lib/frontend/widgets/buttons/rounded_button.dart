import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final Function? onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final double size;

  const RoundedButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed!(),
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
}
