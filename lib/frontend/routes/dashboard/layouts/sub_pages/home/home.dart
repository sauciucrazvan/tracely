import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/dashboard/layouts/sub_pages/home/layouts/home_desktop_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: HomepageDesktopLayout(),
      desktopBody: HomepageDesktopLayout(),
    );
  }
}
