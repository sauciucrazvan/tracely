import 'package:flutter/material.dart';

import 'package:tracely/frontend/routes/checkboxes/checkboxes.dart';
import 'package:tracely/frontend/routes/checkboxes/add/add_checkbox.dart';
import 'package:tracely/frontend/routes/route_manager/components/titlebar.dart';

import '../../../config/messages.dart';
import '../../../widgets/buttons/back_button.dart';
import '../../../widgets/marginals/header.dart';

class ViewCheckboxes extends StatelessWidget {
  final String id;
  final String name;
  final String color;

  const ViewCheckboxes(
      {super.key, required this.id, required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Image.asset(
          "assets/logo.png",
          height: 32,
          width: 32,
        ),
        backgroundColor,
        true,
        leading: const BackLeadingButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),

              // CHECKBOXES
              titleBar(
                context,
                checkboxes,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCheckbox(categoryID: id),
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: const Divider(),
              ),

              BuildCheckboxes(
                id: id,
                name: name,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
