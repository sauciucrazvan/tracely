import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:tracely/backend/functions/decrypt.dart';
import 'package:tracely/frontend/config/messages.dart';

import 'package:tracely/frontend/widgets/marginals/header.dart';
import 'package:tracely/frontend/widgets/buttons/button.dart';
import 'package:tracely/frontend/widgets/buttons/back_button.dart';

class ViewNotesDesktopLayout extends StatefulWidget {
  final Map data;

  const ViewNotesDesktopLayout({super.key, required this.data});

  @override
  State<ViewNotesDesktopLayout> createState() => _ViewNotesDesktopLayoutState();
}

class _ViewNotesDesktopLayoutState extends State<ViewNotesDesktopLayout> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    String title = (widget.data['useEncryption']
        ? decryptText(widget.data['title'], widget.data['iv'])
        : widget.data['title']);

    String content = (widget.data['useEncryption']
        ? decryptText(widget.data['content'], widget.data['iv'])
        : widget.data['content']);

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
              horizontal: 256.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // note title
                Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
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
                          data: content,
                          styleSheet: MarkdownStyleSheet(textScaleFactor: 1.15),
                        )
                      : Text(
                          content,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                ),

                const Divider(),

                const SizedBox(
                  height: 8,
                ),

                Row(
                  children: [
                    Text(
                      "$lastEdit: ${DateFormat("MMM d, yyyy | HH:mm").format(
                        DateTime.parse(
                          widget.data['last_edit'],
                        ),
                      )}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    if (widget.data['useEncryption']) ...[
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.blue,
                        ),
                        child: const Text(
                          "AES Encrypted",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: widget.data['useMarkdown']
                            ? Colors.green.shade700
                            : Colors.red,
                      ),
                      child: const Text(
                        "Markdown",
                        style: TextStyle(
                          color: Colors.white,
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
                    SmallButton(
                      color: Theme.of(context).colorScheme.primary,
                      icon: Icons.arrow_back,
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
