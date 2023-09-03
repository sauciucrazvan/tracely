import 'package:flutter/material.dart';
import 'package:tracely/frontend/routes/checkboxes/edit/layouts/edit_checkbox_desktop_layout.dart';
import 'package:tracely/frontend/routes/checkboxes/edit/layouts/edit_checkbox_mobile_layout.dart';
import 'package:tracely/frontend/routes/responsive_layout.dart';

class EditCheckbox extends StatefulWidget {
  final String categoryID;
  final String checkboxID;
  final String name;
  final String date;

  const EditCheckbox({
    super.key,
    required this.categoryID,
    required this.checkboxID,
    required this.name,
    required this.date,
  });

  @override
  State<EditCheckbox> createState() => _EditCheckboxState();
}

class _EditCheckboxState extends State<EditCheckbox> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: EditCheckboxMobileLayout(
          categoryID: widget.categoryID,
          checkboxID: widget.checkboxID,
          name: widget.name,
          date: widget.date,
        ),
        desktopBody: EditCheckboxDesktopLayout(
          categoryID: widget.categoryID,
          checkboxID: widget.checkboxID,
          name: widget.name,
          date: widget.date,
        ));
  }
}
