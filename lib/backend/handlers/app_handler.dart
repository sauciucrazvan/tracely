import 'package:flutter/material.dart';
import 'package:tracely/backend/domains/connection/connection_gateway.dart';
import 'package:tracely/frontend/widgets/buttons/tile.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tracely/frontend/config/palette.dart';

class Tracely extends StatefulWidget {
  const Tracely({super.key});

  @override
  State<Tracely> createState() => _TracelyState();
}

class _TracelyState extends State<Tracely> {
  bool accessOldWeb = false;

  void updateAccessOldWeb(bool value) {
    setState(() {
      accessOldWeb = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'Tracely',
      home: accessOldWeb
          ? connectionGateway()
          : DiscontinuedAlert(updateAccessOldWeb),
    );
  }
}

class DiscontinuedAlert extends StatelessWidget {
  final void Function(bool) updateAccessOldWeb;

  const DiscontinuedAlert(this.updateAccessOldWeb, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canAccessTracely = (DateTime.now().isBefore(DateTime(2024, 6, 1)));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                height: 64,
                width: 64,
              ),
              const SizedBox(height: 4),
              Text(
                "Tracely",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "was discontinued back in November 2023.\nIn June 2024, the website was completely killed.\n \nIt was meant to be a productivity app, featuring multiple\nsmaller tools. Unfortunately, the ideas behind the app\nwere poorly implemented and refactoring will take way too long.\n\nMoving forward, a more advanced application might be built,\nbut it's not a priority. Take care. :)\n\n- RS",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Text(
                    "GITHUB",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () async {
                    final Uri uri = Uri(
                      scheme: 'https',
                      host: "github.com",
                      path: "/sauciucrazvan",
                    );
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.platformDefault,
                      );
                    }
                  },
                ),
              ),
              if (canAccessTracely) const SizedBox(height: 32),
              if (canAccessTracely)
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 172, 41, 32),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(Icons.warning_rounded,
                            color: Theme.of(context).colorScheme.tertiary,
                            size: 36),
                        Text(
                          "You can still access the old website to backup your data.\nOn the first of June 2024, the website will be gone for good.",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 200,
                          child: Tile(
                            title: "Access Tracely",
                            leading: Icon(Icons.arrow_forward,
                                color: Theme.of(context).colorScheme.secondary),
                            onTap: () => updateAccessOldWeb(true),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
