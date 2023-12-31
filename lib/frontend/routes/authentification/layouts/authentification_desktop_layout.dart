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
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;

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
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
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
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Divider(),
                      Tile(
                        title: google,
                        leading: Image.asset(
                          "assets/images/google_logo.png",
                          width: 32,
                          height: 32,
                        ),
                        onTap: () => AuthentificationService().signIn(context),
                      ),
                      const Divider(),
                      Text(
                        usedData,
                        style: Theme.of(context).textTheme.bodySmall,
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
