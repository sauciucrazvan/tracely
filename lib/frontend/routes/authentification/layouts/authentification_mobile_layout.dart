import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:tracely/backend/domains/authentification/authentification_service.dart';

import '../../../config/messages.dart';
import '../../../widgets/header/header.dart';
import '../../../widgets/buttons/tile.dart';

class AuthentificationMobileLayout extends StatelessWidget {
  const AuthentificationMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: header(
        Image.asset(
          "assets/logo.png",
          height: 32,
          width: 32,
        ),
        Theme.of(context).colorScheme.background,
        true,
      ),
      body: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/animations/login.json",
                    width: 256,
                    height: 256,
                  ),
                ),
                const SizedBox(
                  height: 25,
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
        ),
      ),
    );
  }
}
