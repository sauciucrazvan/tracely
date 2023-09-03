import 'package:flutter/material.dart';

import '../../../../config/messages.dart';
import '../../../expenses/add/add_expense.dart';
import '../../../expenses/chart/expenses_chart.dart';
import '../../../expenses/expenses.dart';
import '../../components/titlebar.dart';

class ExpensesDashboard extends StatefulWidget {
  const ExpensesDashboard({super.key});

  @override
  State<ExpensesDashboard> createState() => _ExpensesDashboardState();
}

class _ExpensesDashboardState extends State<ExpensesDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),

          // Expenses
          titleBar(
            context,
            expenses,
            () => showDialog(
              context: context,
              builder: (context) => const AddExpense(),
            ),
          ),

          const ExpensesChart(),

          const Expanded(
            child: SingleChildScrollView(
              child: BuildExpenses(),
            ),
          ),
        ],
      ),
    );
  }
}
