import 'package:flutter/material.dart';

class BackLeadingButton extends StatelessWidget {
  const BackLeadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.tertiary,
            size: 16,
          ),
        ),
      ),
    );
  }
}
