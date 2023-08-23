import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

import 'layouts/dashboard_desktop_layout.dart';
import 'layouts/dashboard_mobile_layout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: DashboardMobileLayout(),
      desktopBody: DashboardDesktopLayout(),
    );
  }
}
