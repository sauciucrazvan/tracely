import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracely/backend/handlers/routes/reminders/time_handler.dart';

import '../../../config/messages.dart';

class RepeatingMenu extends StatefulWidget {
  final Function(DateTime) onTimeChanged;
  const RepeatingMenu({
    super.key,
    required this.onTimeChanged,
  });

  @override
  State<RepeatingMenu> createState() => _RepeatingMenuState();
}

class _RepeatingMenuState extends State<RepeatingMenu> {
  String selectedRepeatOption = repeatOptions[0];
  int insertedValue = 0;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              every,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    child: TextField(
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.end,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (text) {
                        setState(() {
                          if (text.isNotEmpty) {
                            insertedValue = int.parse(text);
                            widget.onTimeChanged(
                              convertToDate(
                                insertedValue,
                                selectedRepeatOption,
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectedRepeatOption,
                      onChanged: (index) {
                        setState(() {
                          selectedRepeatOption = index!;
                          widget.onTimeChanged(
                            convertToDate(
                              insertedValue,
                              selectedRepeatOption,
                            ),
                          );
                        });
                      },
                      items:
                          repeatOptions.map<DropdownMenuItem>((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
