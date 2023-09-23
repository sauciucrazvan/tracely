import 'package:flutter/material.dart';
import 'package:tracely/backend/domains/goals/goals_manipulator.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/widgets/buttons/tile.dart';

import 'package:tracely/frontend/routes/route_manager/layouts/sub_pages/home/components/statistic_widget.dart';

import 'package:tracely/backend/handlers/users/account_handler.dart';

import 'package:tracely/backend/domains/notes/notes_manipulator.dart';
import 'package:tracely/backend/domains/expenses/expenses_manipulator.dart';
import 'package:tracely/backend/domains/checklists/checklist_manipulator.dart';

class HomepageDesktopLayout extends StatefulWidget {
  const HomepageDesktopLayout({super.key});

  @override
  State<HomepageDesktopLayout> createState() => _HomepageDesktopLayoutState();
}

class _HomepageDesktopLayoutState extends State<HomepageDesktopLayout> {
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;

    // Displays a different message everyday
    int index = DateTime.now().day.toInt() % welcome.length;

    String tipsText = "";

    for (var tip in tipsList) {
      tipsText = "$tipsText$tip\n";
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // Title bar
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  welcome.elementAt(index),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  getName(),
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left,
                ),
              ],
            ),

            const SizedBox(height: 50),

            // Statistics meter
            Text(
              stats,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                StreamBuilder(
                  stream: getNotesStream(),
                  builder: (context, snapshot) {
                    int notes = 0;

                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value is Map) {
                      Map<dynamic, dynamic> map =
                          snapshot.data?.snapshot.value as Map;
                      notes = map.length;
                    }

                    return StatisticWidget(
                      title: notesSaved,
                      count: notes,
                      icon: Icons.event_note,
                    );
                  },
                ),
                const SizedBox(width: 16),
                StreamBuilder(
                  stream: getGoalsStream(),
                  builder: (context, snapshot) {
                    int goals = 0;

                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value is Map) {
                      Map<dynamic, dynamic> map =
                          snapshot.data?.snapshot.value as Map;
                      goals = map.length;
                    }

                    return StatisticWidget(
                      title: goalsSaved,
                      count: goals,
                      icon: Icons.track_changes,
                    );
                  },
                ),
                const SizedBox(width: 16),
                StreamBuilder(
                  stream: getExpensesStream(),
                  builder: (context, snapshot) {
                    int expenses = 0;

                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value is Map) {
                      Map<dynamic, dynamic> map =
                          snapshot.data?.snapshot.value as Map;
                      expenses = map.length;
                    }

                    return StatisticWidget(
                      title: expensesSaved,
                      count: expenses,
                      icon: Icons.wallet,
                    );
                  },
                ),
                const SizedBox(width: 16),
                StreamBuilder(
                  stream: getChecklistsStream(),
                  builder: (context, snapshot) {
                    int checklists = 0;

                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value is Map) {
                      Map<dynamic, dynamic> map =
                          snapshot.data?.snapshot.value as Map;
                      checklists = map.length;
                    }

                    return StatisticWidget(
                      title: todoSaved,
                      count: checklists,
                      icon: Icons.event,
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 50),

            // Quick tips

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tips,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tipsText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  width: 250,
                  child: Tile(
                    title: learnMarkdown,
                    leading: Icon(
                      Icons.format_color_text_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () async {
                      final Uri uri = Uri(
                        scheme: 'https',
                        host: "markdownguide.org",
                        path: "/getting-started",
                      );
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.inAppWebView,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // About Tracely
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  about,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "$appName $appDesc",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  githubDesc,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 25),
                Text(
                  downloadAndroidDesc,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 250,
                  child: Tile(
                    title: downloadAndroid,
                    leading: Icon(
                      Icons.android,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () async {
                      final Uri uri = Uri(
                        scheme: 'https',
                        host: "github.com",
                        path: "/sauciucrazvan/tracely/releases",
                      );
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.inAppWebView,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Contribute to Tracely
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contribute,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  contributeDesc,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Tile(
                        title: sourceCode,
                        leading: Icon(
                          Icons.code,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onTap: () async {
                          final Uri uri = Uri(
                            scheme: 'https',
                            host: "github.com",
                            path: "/sauciucrazvan/tracely",
                          );
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.inAppWebView,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 150,
                      child: Tile(
                        title: supportUs,
                        leading: Icon(
                          Icons.paypal,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onTap: () async {
                          final Uri uri = Uri(
                            scheme: 'https',
                            host: "paypal.me",
                            path: "/sauciucrazvan",
                          );
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.inAppWebView,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
