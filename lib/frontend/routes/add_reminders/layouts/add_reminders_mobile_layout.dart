import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/messages.dart';

import '../../../widgets/header/header.dart';
import '../../../widgets/buttons/button.dart';
import '../../../widgets/buttons/back_button.dart';
import '../../../widgets/notifications/elevated_notification.dart';

import '../components/repeating_menu.dart';
import '../components/static_menu.dart';

class AddRemindersMobileLayout extends StatefulWidget {
  const AddRemindersMobileLayout({super.key});

  @override
  State<AddRemindersMobileLayout> createState() =>
      _AddRemindersMobileLayoutState();
}

class _AddRemindersMobileLayoutState extends State<AddRemindersMobileLayout> {
  final TextEditingController _titleController = TextEditingController();

  bool shouldRepeat = false;

  DateTime date = DateTime.now();

  void onTimeChanged(DateTime date) {
    setState(() {
      this.date = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Image.asset(
          "assets/logo.png",
          height: 32,
          width: 32,
        ),
        backgroundColor,
        true,
        leading: const BackLeadingButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // add a new reminder
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addReminder,
                      style: GoogleFonts.arimo(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Lottie.asset(
                      "assets/animations/alarm.json",
                      height: 64,
                      width: 64,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                // reminder title
                Text(
                  chooseReminderTitle,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: TextField(
                    controller: _titleController,
                    maxLength: 64,
                    maxLines: 1,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      counterText: '',
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                const Divider(),

                // reminder type (repeating / static)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectReminderType,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: shouldRepeat,
                      onChanged: (value) {
                        setState(() => shouldRepeat = value);
                      },
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),

                // duration based on shouldRepeat: for static ones, just show a date selector / for repeating ones show repeating every (minute/hour/day/year) and value
                shouldRepeat
                    ? RepeatingMenu(
                        onTimeChanged: onTimeChanged,
                      )
                    : StaticMenu(
                        onTimeChanged: onTimeChanged,
                      ),

                // add/cancel button
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    actionButton(
                      context,
                      backgroundColor: primaryColor,
                      icon: Icons.done,
                      onPressed: () {
                        String text = _titleController.text;
                        if (text.isEmpty) {
                          return showElevatedNotification(
                              context, reminderWithoutName, Colors.red);
                        }
                        //print("${_titleController.text} / $date");
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    actionButton(
                      context,
                      backgroundColor: Colors.red,
                      icon: Icons.close,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
