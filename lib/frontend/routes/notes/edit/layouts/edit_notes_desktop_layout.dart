import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:tracely/backend/domains/notes/notes_manipulator.dart';

import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/widgets/buttons/button.dart';

import 'package:tracely/frontend/widgets/header/header.dart';
import 'package:tracely/frontend/widgets/buttons/back_button.dart';
import 'package:tracely/frontend/widgets/notifications/elevated_notification.dart';

class EditNotesDesktopLayout extends StatefulWidget {
  final String id;
  final Map data;

  const EditNotesDesktopLayout(
      {super.key, required this.id, required this.data});

  @override
  State<EditNotesDesktopLayout> createState() => _EditNotesDesktopLayoutState();
}

class _EditNotesDesktopLayoutState extends State<EditNotesDesktopLayout> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    _titleController.text = widget.data['title'];

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
                Center(
                  child: Lottie.asset(
                    "assets/animations/note.json",
                    height: 256,
                    width: 256,
                  ),
                ),

                // add note title
                Text(
                  modifyNote,
                  style: GoogleFonts.arimo(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // note title
                Text(
                  editNoteTitle,
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

                // add note content
                Text(
                  editNoteContent,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                MarkdownTextInput(
                  (String value) {},
                  widget.data['content'],
                  label: 'Description',
                  actions: const [
                    MarkdownType.bold,
                    MarkdownType.italic,
                    MarkdownType.strikethrough,
                    MarkdownType.list,
                    //MarkdownType.title, <--- bugged for some reason, may fix later
                    MarkdownType.blockquote,
                    MarkdownType.code,
                    MarkdownType.separator,
                    MarkdownType.link,
                  ],
                  controller: _contentController,
                  textStyle: TextStyle(color: textColor, fontSize: 16),
                ),

                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      shouldUseMarkdown,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: widget.data['useMarkdown'],
                      onChanged: (value) {
                        setState(() => widget.data['useMarkdown'] = value);
                      },
                    ),
                  ],
                ),

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
                        String title = _titleController.text;
                        String content = _contentController.text;
                        if (title.isEmpty) {
                          return showElevatedNotification(
                              context, noteWithoutName, Colors.red);
                        }

                        if (content.isEmpty) {
                          return showElevatedNotification(
                              context, noteWithoutContent, Colors.red);
                        }

                        editNote(widget.id, title, content,
                            widget.data['useMarkdown']);
                        Navigator.pop(context);
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
