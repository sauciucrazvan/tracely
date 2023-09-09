import 'package:flutter/material.dart';

import '../../components/topbar.dart';
import '../../components/trackers/about.dart';
import '../../components/trackers/statistics.dart';
import '../../components/trackers/tips.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: SingleChildScrollView(
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
                    child: showStatistics(context),
                  ),

                  // ABOUT
                  const SizedBox(
                    height: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: showAbout(context),
                  ),

                  // TIPS
                  const SizedBox(
                    height: 16,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: showTips(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}