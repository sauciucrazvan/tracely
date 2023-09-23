import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracely/backend/domains/goals/goals_manipulator.dart';
import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/widgets/buttons/button.dart';

class UpdateGoalProgress extends StatefulWidget {
  final String goalID;
  final String goal;
  final String details;
  final int progress;
  final int maxProgress;

  const UpdateGoalProgress({
    super.key,
    required this.goalID,
    required this.goal,
    required this.details,
    required this.progress,
    required this.maxProgress,
  });

  @override
  State<UpdateGoalProgress> createState() => UpdateGoalProgressState();
}

class UpdateGoalProgressState extends State<UpdateGoalProgress> {
  final TextEditingController _progressController = TextEditingController();

  @override
  void initState() {
    _progressController.text = widget.progress.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Center(
        child: Image.asset(
          "assets/logo.png",
          width: 32,
          height: 32,
        ),
      ),
      content: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(updateProgress, style: Theme.of(context).textTheme.bodySmall),
            Text(widget.goal, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.details,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _progressController,
                    maxLength: widget.maxProgress.toString().length,
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
                          color: backgroundColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      counterText: '',
                    ),
                    style: TextStyle(color: textColor),
                    textAlign: TextAlign.right,
                  ),
                ),
                Text(" / ", style: Theme.of(context).textTheme.bodyMedium),
                Text("${widget.maxProgress}",
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallButton(
                  icon: Icons.done,
                  color: primaryColor,
                  pressed: () {
                    if (_progressController.text.isEmpty) return;
                    int progress = int.parse(_progressController.text);

                    if (progress > widget.maxProgress || progress < 0) return;

                    if (widget.progress != progress) {
                      updateGoalProgress(widget.goalID, progress);
                    }
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8),
                SmallButton(
                  icon: Icons.close,
                  color: Colors.red,
                  pressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
