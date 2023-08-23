import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

import 'layouts/authentification_desktop_layout.dart';
import 'layouts/authentification_mobile_layout.dart';

class Authentification extends StatefulWidget {
  const Authentification({super.key});

  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: AuthentificationMobileLayout(),
      desktopBody: AuthentificationDesktopLayout(),
    );
  }
}
