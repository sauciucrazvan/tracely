import 'package:flutter/widgets.dart';

import 'package:tracely/frontend/routes/checkboxes/add/layouts/add_checkbox_desktop_layout.dart';
import 'package:tracely/frontend/routes/checkboxes/add/layouts/add_checkbox_mobile_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class AddCheckbox extends StatefulWidget {
  final String categoryID;

  const AddCheckbox({super.key, required this.categoryID});

  @override
  State<AddCheckbox> createState() => _AddCheckboxState();
}

class _AddCheckboxState extends State<AddCheckbox> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: AddCheckboxMobileLayout(categoryID: widget.categoryID),
      desktopBody: AddCheckboxDesktopLayout(categoryID: widget.categoryID),
    );
  }
}
