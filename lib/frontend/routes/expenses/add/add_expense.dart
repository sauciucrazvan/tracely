import 'package:flutter/widgets.dart';

import 'package:tracely/frontend/routes/expenses/add/layouts/add_expense_desktop_layout.dart';
import 'package:tracely/frontend/routes/expenses/add/layouts/add_expense_mobile_layout.dart';

import 'package:tracely/frontend/routes/responsive_layout.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: AddExpenseMobileLayout(),
      desktopBody: AddExpenseDesktopLayout(),
    );
  }
}
