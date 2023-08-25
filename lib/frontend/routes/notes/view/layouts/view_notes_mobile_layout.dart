import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:tracely/frontend/config/messages.dart';

import 'package:tracely/frontend/widgets/buttons/button.dart';

import 'package:tracely/frontend/widgets/header/header.dart';
import 'package:tracely/frontend/widgets/buttons/back_button.dart';

class ViewNotesMobileLayout extends StatefulWidget {
  final Map data;

  const ViewNotesMobileLayout({super.key, required this.data});

  @override
  State<ViewNotesMobileLayout> createState() => _ViewNotesMobileLayoutState();
}

class _ViewNotesMobileLayoutState extends State<ViewNotesMobileLayout> {
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;

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
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // note title
                Center(
                  child: Text(
                    widget.data['title'],
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Divider(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: widget.data['useMarkdown']
                      ? MarkdownBody(
                          data: widget.data['content'],
                          styleSheet: MarkdownStyleSheet(textScaleFactor: 1.15),
                        )
                      : Text(
                          widget.data['content'],
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                          ),
                        ),
                ),

                const Divider(),

                const SizedBox(
                  height: 8,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$lastEdit: ${DateFormat("HH:mm dd/MM/yyyy").format(
                        DateTime.parse(
                          widget.data['last_edit'],
                        ),
                      )}",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: widget.data['useMarkdown']
                            ? Colors.green.shade700
                            : Colors.red,
                      ),
                      child: Text(
                        "MD",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    actionButton(
                      context,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      icon: Icons.arrow_back,
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