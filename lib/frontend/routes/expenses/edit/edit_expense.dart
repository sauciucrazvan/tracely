import 'package:flutter/widgets.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

import 'layouts/edit_expense_desktop_layout.dart';
import 'layouts/edit_expense_mobile_layout.dart';

class EditExpense extends StatefulWidget {
  final String id;
  final String expense;
  final String currency;
  final double value;
  final String date;

  const EditExpense({
    super.key,
    required this.id,
    required this.expense,
    required this.currency,
    required this.value,
    required this.date,
  });

  @override
  State<EditExpense> createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: EditExpenseMobileLayout(
        id: widget.id,
        expense: widget.expense,
        currency: widget.currency,
        value: widget.value,
        date: widget.date,
      ),
      desktopBody: EditExpenseDesktopLayout(
        id: widget.id,
        expense: widget.expense,
        currency: widget.currency,
        value: widget.value,
        date: widget.date,
      ),
    );
  }
}
