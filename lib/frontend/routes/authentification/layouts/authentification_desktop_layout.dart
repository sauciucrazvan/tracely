import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:tracely/backend/domains/authentification/authentification_service.dart';

import '../../../config/messages.dart';
import '../../../widgets/buttons/tile.dart';

class AuthentificationDesktopLayout extends StatelessWidget {
  const AuthentificationDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          child: Row(
            children: [
              Drawer(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 64,
                        width: 64,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                appName,
                                style: GoogleFonts.arimo(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                appDesc,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 256),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Lottie.asset("assets/animations/login.json"),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        login,
                        style: GoogleFonts.arimo(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        services,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                      const Divider(),
                      tile(
                        context,
                        google,
                        Image.asset(
                          "assets/images/google_logo.png",
                          width: 32,
                          height: 32,
                        ),
                        () => AuthentificationService().signIn(context),
                      ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // Tile(
                      //   context,
                      //   facebook,
                      //   Image.asset(
                      //     "assets/images/facebook_logo.png",
                      //     width: 32,
                      //     height: 32,
                      //   ),
                      //   () {},
                      // ),
                      const Divider(),
                      Text(
                        usedData,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
