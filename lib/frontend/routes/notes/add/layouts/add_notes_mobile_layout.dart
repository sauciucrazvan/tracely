import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:tracely/backend/domains/notes/notes_manipulator.dart';

import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/widgets/buttons/button.dart';

import 'package:tracely/frontend/widgets/marginals/header.dart';
import 'package:tracely/frontend/widgets/buttons/back_button.dart';
import 'package:tracely/frontend/widgets/notifications/elevated_notification.dart';

class AddNotesMobileLayout extends StatefulWidget {
  const AddNotesMobileLayout({super.key});

  @override
  State<AddNotesMobileLayout> createState() => _AddNotesMobileLayoutState();
}

class _AddNotesMobileLayoutState extends State<AddNotesMobileLayout> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool useMarkdown = true;
  bool useEncryption = true;

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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // add note title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addNote,
                      style: GoogleFonts.arimo(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Lottie.asset(
                      "assets/animations/note.json",
                      height: 64,
                      width: 64,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                // note title
                Text(
                  chooseNoteTitle,
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
                  enterNoteContent,
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
                  "",
                  label: 'Description',
                  actions: const [
                    MarkdownType.bold,
                    MarkdownType.italic,
                    MarkdownType.strikethrough,
                    MarkdownType.list,
                    MarkdownType.blockquote,
                    MarkdownType.code,
                    MarkdownType.separator,
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
                      shouldEncryptNote,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      activeColor: primaryColor,
                      value: useEncryption,
                      onChanged: (value) {
                        setState(() => useEncryption = value);
                      },
                    ),
                  ],
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
                      value: useMarkdown,
                      onChanged: (value) {
                        setState(() => useMarkdown = value);
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
                    SmallButton(
                      color: primaryColor,
                      icon: Icons.done,
                      pressed: () {
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

                        insertNote(title, content, useMarkdown, useEncryption);
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
