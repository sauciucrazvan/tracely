import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:tracely/frontend/routes/notes/dashboard_notes.dart';
import 'package:tracely/frontend/widgets/navigation_bar/navigation_bar.dart';

import '../../../config/messages.dart';
import '../../../widgets/buttons/tile.dart';
import '../../../widgets/header/header.dart';

import '../components/topbar.dart';

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Container(),
        secondaryColor,
        true,
        leading: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            dashboard,
            style: GoogleFonts.arimo(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        leadingWidth: 128,
        trailing: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/logo.png",
              height: 32,
              width: 32,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavigationPanel(index: 0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  topBar(context),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            /*
              3 cards: about, notes & to do

              notes animation | notes title
                              | description
                              | jump to notes

              todo animation  | todo title
                              | description
                              | jump to todo

            */

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          // animation
                          Center(
                            child: Lottie.asset(
                              "assets/animations/about.json",
                              width: 128,
                              height: 128,
                            ),
                          ),

                          Text(
                            about,
                            style: GoogleFonts.arimo(
                              color: textColor,
                              fontSize: 20,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.25,
                                child: Text(
                                  "$appName $appDesc",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          children: [
                            const Divider(),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: tile(
                                    context,
                                    jumpNotes,
                                    Lottie.asset(
                                      "assets/animations/note_taking.json",
                                      width: 32,
                                      height: 32,
                                    ),
                                    () => Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const NotesDashboard(),
                                      ),
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
                                SizedBox(
                                  width: 300,
                                  child: tile(
                                    context,
                                    jumpTodo,
                                    Lottie.asset(
                                      "assets/animations/todo.json",
                                      width: 32,
                                      height: 32,
                                    ),
                                    () => Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const NotesDashboard(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
