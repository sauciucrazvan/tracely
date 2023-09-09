import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tracely/frontend/config/messages.dart';

import 'package:tracely/backend/domains/checkboxes/checkbox_manipulator.dart';

import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/buttons/button.dart';
import '../../../../widgets/marginals/header.dart';
import '../../../../widgets/notifications/elevated_notification.dart';

class AddCheckboxDesktopLayout extends StatefulWidget {
  final String categoryID;

  const AddCheckboxDesktopLayout({super.key, required this.categoryID});

  @override
  State<AddCheckboxDesktopLayout> createState() =>
      _AddCheckboxDesktopLayoutState();
}

class _AddCheckboxDesktopLayoutState extends State<AddCheckboxDesktopLayout> {
  final TextEditingController _titleController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(selectedDate.year + 5),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
            padding: const EdgeInsets.symmetric(horizontal: 256.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/animations/check.json",
                    height: 128,
                    width: 128,
                  ),
                ),

                Text(
                  addCheckbox,
                  style: GoogleFonts.arimo(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // checklist title
                Text(
                  chooseTitleCheckbox,
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
                    maxLength: 128,
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

                // date selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectCheckboxDate,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat("MMM dd, yyyy").format(selectedDate),
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SmallButton(
                          color: secondaryColor,
                          icon: Icons.calendar_today,
                          pressed: () => selectDate(context),
                        ),
                      ],
                    ),
                  ],
                ),

                // add/cancel button
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallButton(
                      color: primaryColor,
                      icon: Icons.done,
                      pressed: () {
                        String text = _titleController.text;
                        if (text.isEmpty) {
                          return showElevatedNotification(
                              context, checkboxWithoutName, Colors.red);
                        }

                        insertCheckbox(
                          widget.categoryID,
                          text,
                          selectedDate.toString(),
                        );

                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SmallButton(
                      color: Colors.red,
                      icon: Icons.close,
                      pressed: () => Navigator.pop(context),
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
