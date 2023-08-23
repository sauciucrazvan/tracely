import 'package:flutter/material.dart';

AppBar header(Widget title, Color backgroundColor, bool centered,
    {Widget? leading, double? leadingWidth, List<Widget>? trailing}) {
  return AppBar(
    title: title,
    backgroundColor: backgroundColor,
    centerTitle: centered,
    leading: leading,
    leadingWidth: leadingWidth,
    actions: trailing,
    shadowColor: Colors.transparent,
  );
}
