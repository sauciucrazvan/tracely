import 'package:flutter/widgets.dart';
import 'package:tracely/frontend/routes/goals/add/layouts/add_goal_desktop_layout.dart';
import 'package:tracely/frontend/routes/goals/add/layouts/add_goal_mobile_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class AddGoal extends StatefulWidget {
  const AddGoal({super.key});

  @override
  State<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: AddGoalMobileLayout(),
      desktopBody: AddGoalDesktopLayout(),
    );
  }
}
