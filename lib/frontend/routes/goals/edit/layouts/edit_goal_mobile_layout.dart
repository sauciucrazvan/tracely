import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/backend/domains/goals/goals_manipulator.dart';

import 'package:tracely/frontend/config/messages.dart';

import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/buttons/button.dart';
import '../../../../widgets/marginals/header.dart';
import '../../../../widgets/notifications/elevated_notification.dart';

class EditGoalMobileLayout extends StatefulWidget {
  final String goalID;
  final String goal;
  final String details;
  final String deadline;
  final int maxProgress;

  const EditGoalMobileLayout({
    super.key,
    required this.goalID,
    required this.goal,
    required this.details,
    required this.deadline,
    required this.maxProgress,
  });

  @override
  State<EditGoalMobileLayout> createState() => _EditGoalMobileLayoutState();
}

class _EditGoalMobileLayoutState extends State<EditGoalMobileLayout> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _progressController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(selectedDate.year + 5),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    _goalController.text = widget.goal;
    _detailsController.text = widget.details;
    _progressController.text = widget.maxProgress.toString();
    selectedDate = DateTime.parse(widget.deadline);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      editGoal,
                      style: GoogleFonts.arimo(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Lottie.asset(
                      "assets/animations/goal.json",
                      height: 64,
                      width: 64,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                // goal title
                Text(
                  chooseTitleGoal,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(
                  height: 4,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: TextField(
                    controller: _goalController,
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

                const SizedBox(height: 10),

                const Divider(),

                const SizedBox(height: 10),

                // goal desc
                Text(
                  chooseDescriptionGoal,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(
                  height: 4,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _detailsController,
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

                const SizedBox(height: 10),

                const Divider(),

                const SizedBox(height: 10),

                Text(
                  chooseGoalProgress,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(
                  height: 4,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _progressController,
                    maxLength: 128,
                    maxLines: 1,
                    obscureText: false,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                    ],
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

                const SizedBox(height: 25),

                // deadline selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectGoalDeadline,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat("MMM dd, yyyy").format(selectedDate),
                          style: Theme.of(context).textTheme.bodyMedium,
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
                        String goal = _goalController.text;
                        String details = _detailsController.text;

                        if (goal.isEmpty) {
                          return showElevatedNotification(
                              context, goalWithoutName, Colors.red);
                        }

                        if (_progressController.text.isEmpty) {
                          return showElevatedNotification(
                              context, goalWithoutProgress, Colors.red);
                        }

                        int maxProgress = int.parse(_progressController.text);

                        if (maxProgress < 1 || maxProgress > 10000) {
                          return showElevatedNotification(
                              context, invalidProgress, Colors.red);
                        }

                        if (details.isEmpty) details = noDetailsAttached;

                        updateGoal(
                          widget.goalID,
                          goal,
                          details,
                          selectedDate.toString(),
                          maxProgress,
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
