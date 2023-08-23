import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracely/frontend/widgets/buttons/button.dart';

import '../../../config/messages.dart';

class StaticMenu extends StatefulWidget {
  final Function(DateTime) onTimeChanged;
  const StaticMenu({super.key, required this.onTimeChanged});

  @override
  State<StaticMenu> createState() => _StaticMenuState();
}

class _StaticMenuState extends State<StaticMenu> {
  DateTime returnValue = DateTime.now();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  DateTime convertTime(TimeOfDay timeOfDay, DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(selectedDate.year + 5));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.onTimeChanged(convertTime(selectedTime, selectedDate));
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.onTimeChanged(convertTime(selectedTime, selectedDate));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat("dd/MM/yyyy")
                      .format(convertTime(selectedTime, selectedDate)),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                actionButton(
                  context,
                  backgroundColor: secondaryColor,
                  icon: Icons.calendar_today,
                  onPressed: () => selectDate(context),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat("HH:mm")
                      .format(convertTime(selectedTime, selectedDate)),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                actionButton(
                  context,
                  backgroundColor: secondaryColor,
                  icon: Icons.timer,
                  onPressed: () => selectTime(context),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
