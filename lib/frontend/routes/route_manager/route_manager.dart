import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

import 'layouts/route_manager_desktop_layout.dart';
import 'layouts/route_manager_mobile_layout.dart';

class RouteManager extends StatefulWidget {
  const RouteManager({super.key});

  @override
  State<RouteManager> createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: RouteManagerMobileLayout(),
      desktopBody: RouteManagerDesktopLayout(),
    );
  }
}
