import 'package:flutter/material.dart';

Widget buildReminders(BuildContext context,
    {bool horizontal = true, int countPerLine = 1}) {
  Color textColor = Theme.of(context).colorScheme.tertiary;
  Color secondaryColor = Theme.of(context).colorScheme.secondary;

  int count = 25;

  return SingleChildScrollView(
    scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
    child: GridView.builder(
      shrinkWrap: true,
      scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
      itemCount: count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: countPerLine,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm,
                    color: textColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Reminder #${index + 1}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '12:00 ${index % 3 == 0 ? 'daily' : ''}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {},
        );
      },
    ),
  );
}
