import 'package:flutter/material.dart';
import 'package:tracely/frontend/routes/expenses/calculator/expenses_income_calculator.dart';

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
  bool openedChart = false;
  bool openedCalculator = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;

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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            expensesChartTitle,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.secondary),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.secondary),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: () =>
                              setState(() => openedChart = !openedChart),
                          child: openedChart
                              ? Icon(
                                  Icons.keyboard_arrow_left,
                                  color: textColor,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: textColor,
                                ),
                        ),
                      ],
                    ),
                    if (openedChart) const ExpensesChart(),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            expensesCalculatorTitle,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.secondary),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.secondary),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: () => setState(
                              () => openedCalculator = !openedCalculator),
                          child: openedCalculator
                              ? Icon(
                                  Icons.keyboard_arrow_left,
                                  color: textColor,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: textColor,
                                ),
                        ),
                      ],
                    ),
                    if (openedCalculator) const ExpensesIncomeCalculator(),
                  ],
                ),
              ),
            ),
          ),

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
