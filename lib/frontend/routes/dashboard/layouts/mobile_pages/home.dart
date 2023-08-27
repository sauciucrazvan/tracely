import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/routes/dashboard/components/topbar.dart';

import '../../../../../backend/domains/notes/notes_manipulator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return SafeArea(
      child: Column(
        children: [
          // TOP BAR
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

          // content
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // STATS
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: secondaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stats,
                                style: GoogleFonts.roboto(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              numberOfNotes(context),
                              Text(
                                "$todoSaved 0",
                                style: GoogleFonts.roboto(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Lottie.asset(
                            "assets/animations/chart.json",
                            width: 64,
                            height: 64,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ABOUT
                const SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: secondaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "About",
                                style: GoogleFonts.roboto(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "$appName $appDesc",
                                  style: GoogleFonts.roboto(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Lottie.asset(
                            "assets/animations/about.json",
                            width: 64,
                            height: 64,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
