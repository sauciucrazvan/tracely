import 'package:flutter/material.dart';

class StatisticWidget extends StatefulWidget {
  final String title;
  final int count;
  final IconData icon;

  const StatisticWidget({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    final hoveredAnimation = Matrix4.identity()..translate(0, -10, 0);

    return MouseRegion(
      onEnter: (event) => setState(() {
        onHover = true;
      }),
      onExit: (event) => setState(() {
        onHover = false;
      }),
      child: AnimatedContainer(
        transform: onHover ? hoveredAnimation : Matrix4.identity(),
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: BoxDecoration(
            color: onHover
                ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(widget.icon, color: Colors.white),
                Text(
                  "${widget.count}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
